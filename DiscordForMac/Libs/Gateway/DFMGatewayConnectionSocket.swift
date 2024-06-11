//
//  DFMGatewayConnectionSocket.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/05/2024.
//

import Foundation

public class DFMGatewayConnectionSocket {
    
    private var socket: URLSessionWebSocketTask!
    
    private var receiveInfiniteProcess: DispatchWorkItem?
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private let instanceNonce: UInt32
    
    private var heartbeatInterval: Double?
    private var heartbeatCount: Int?
    private var heartbeatProcess: DispatchWorkItem?
    private var heartbeatKeepCaring: Bool = true
    private var heartbeatACK: Bool = false
    
    private var sessionID: String = ""
    private var resumeGatewayURL: String = ""
    
    internal init(
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(DateFormatter.customFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormatter)
        
        self.instanceNonce = arc4random()
        
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func start() {
        socket = URLSession.shared.webSocketTask(with: URL(string: "wss://gateway.discord.gg/?v=10&encoding=json")!)
        socket.maximumMessageSize = 149357600
        socket.resume()
        
        // start with the infinite receiving loop
        self.receive()
    }
    
    deinit {
        if heartbeatProcess != nil {
            heartbeatProcess?.cancel()
            heartbeatProcess = nil
        }
        if receiveInfiniteProcess != nil {
            receiveInfiniteProcess?.cancel()
            receiveInfiniteProcess = nil
        }
        if socket != nil {
            socket.cancel(with: .goingAway, reason: .none)
            socket = nil
        }
    }
    
    private func processInput(_ data: Data, _ decoder: JSONDecoder, _ encoder: JSONEncoder) {
        do {
            let op = try decoder.decode(DFMGatewayOp.self, from: data)
            if let s = op.s {
                if s > (heartbeatCount ?? 0) {
                    heartbeatCount = s
                }
            }
            
            if op.op == .heartbeat {
                // get the heartbeat sequence and set it.
                let d = try decoder.decode(DFMGatewayHeartbeat.self, from: data)
                self.heartbeatCount = d.d
                // stop heartbeat from repeating prematurely
                heartbeatProcess?.cancel()
                // server acknowledged the heartbeat
                self.heartbeatACK = true
                // send heartbeat
                heartbeatSend(heartbeatInterval: heartbeatInterval!)
            } else if op.op == .dispatch {
//                print("recieved opcode 0. *to be implemented*")
                // send notification center event listeners to handle these on other files
                switch op.t {
                case .Ready:
                    let d = try decoder.decode(DFMGatewayServerReady.self, from: data)
                    let dd = d.d
                    self.resumeGatewayURL = dd.resumeGatewayUrl
                    self.sessionID = dd.sessionId
                    
                    let usersDict: [Snowflake: DFMUser] = dd.users.reduce([Snowflake: DFMUser]()) { (dict, user) -> [Snowflake: DFMUser] in
                        var dict = dict
                        dict[user.id] = user
                        return dict
                    }
                    
                    let usersReferenceData = DFMGatewayUpdate(type: .InitialState, data: usersDict)
                    NotificationCenter.default.post(name: Notification.Name("DFMUserReferencesUpdate"), object: usersReferenceData)
                    
                    let userData = DFMGatewayUpdate(type: .InitialState, data: dd.user)
                    NotificationCenter.default.post(name: Notification.Name("DFMUserUpdate"), object: userData)
                    
                    let guildsData = DFMGatewayUpdate(type: .InitialState, data: dd.guilds)
                    NotificationCenter.default.post(name: Notification.Name("DFMGuildsUpdate"), object: guildsData)
                    
                    let privateChannelsData = DFMGatewayUpdate(type: .InitialState, data: dd.privateChannels)
                    NotificationCenter.default.post(name: Notification.Name("DFMPrivateChannelsUpdate"), object: privateChannelsData)
                
                    Task {
                        await DFMInformation.shared.setLoadingScreen((false, "Success"))
                    }
                case .ReadySupplemental:
                    let d = try decoder.decode(DFMGatewayServerReadySupplemental.self, from: data)
                    let dd = d.d
                    
                    let presenceData = DFMGatewayUpdate(type: .InitialState, data: dd.mergedPresences.friends)
                    NotificationCenter.default.post(name: Notification.Name("DFMPresencesUpdate"), object: presenceData)
                case .MessageCreate:
                    let d = try decoder.decode(DFMGatewayServerMessage.self, from: data)
                    let dd = d.d
                    
                    print(dd)
                    
                    let messageData = DFMGatewayUpdate(type: .UpdateState, data: dd)
                    NotificationCenter.default.post(name: Notification.Name("DFMMessageUpdate"), object: messageData)
                default: break
                    // print("unknown op type")
                    // print(String(data: data, encoding: .utf8)!)
                }
            } else if op.op == .hello {
                Task {
                    await DFMInformation.shared.setLoadingScreen((true, "Authenticating"))
                }
                // this is the hello event. should only be received once
                let d = try decoder.decode(DFMGatewayServerHello.self, from: data)
                self.heartbeatInterval = d.d.heartbeatInterval // get the heartbeat interval
                //  + (Double(self.heartbeatInterval!) * 0.1))
                DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(
                    Int(heartbeatInterval! * 0.6)
                )) {
                    self.heartbeatSend(heartbeatInterval: self.heartbeatInterval!)
                }
                identify() // identify after hello
            } else if op.op == .heartbeatAck {
                self.heartbeatACK = true
            } else {
                print("what (nothing matches): Op \(op.op)")
            }
        } catch {
            print("Unexpected inability to decode... \(error)")
            print(String(data: data, encoding: .utf8)!)
            fatalError()
        }
    }
    
    private func identify() {
        let req = try! encoder.encode(DFMGatewayClientIdentify())
        Task {
            await self.send(req)
        }
        Task {
            await DFMInformation.shared.setLoadingScreen((true, "Waiting for server data"))
        }
    }
    
    private func resume() {
        // assume this was only received because of a resumable connection.
        // since socket is dead, redefine socket
        self.socket = URLSession.shared.webSocketTask(with: URL(string: "wss://gateway.discord.gg/?v=10&encoding=json")!)
    }
    
    public func send(_ data: Data) async {
//        print(String(data: data, encoding: .utf8)!)
        let dataToSend = URLSessionWebSocketTask.Message.data(data)
        
        do {
            try await socket.send(dataToSend)
        } catch {
            print("\(instanceNonce): failed sending data \(data): \(error)")
            // failed to send usually means somethings up, so let it slide
            fatalError()
        }
    }
    
    private func receive() {
        socket.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    self.processInput(data, self.decoder, self.encoder)
                    self.receiveInfiniteProcess = DispatchWorkItem(block: {
                        self.receive()
                    })
                    DispatchQueue.main.async(execute: self.receiveInfiniteProcess!)
                case .string(let text):
                    self.processInput(text.data(using: .utf8)!, self.decoder, self.encoder)
                    self.receiveInfiniteProcess = DispatchWorkItem(block: {
                        self.receive()
                    })
                    DispatchQueue.main.async(execute: self.receiveInfiniteProcess!)
                @unknown default:
                    print("weird new type of output that shouldn't exist. call it a bug and fix it later.")
                    fatalError()
                }
            case .failure(let error):
                print("Error when receiving: \(error)")
                print("time: \(Date())")
                // TODO: Handle failure of receiving by reconnecting with resume or smth
                // preconditionFailure("need to write an enum for receive errors.")
                
//                // for now, unconditionally attempt reconnection.
//                self.heartbeatProcess?.cancel()
//                self.heartbeatProcess = nil
//                self.receiveInfiniteProcess?.cancel()
//                self.receiveInfiniteProcess = nil
//                self.socket.cancel(with: .goingAway, reason: .none)
//                self.socket = nil
//                Task {
//                    self.heartbeatKeepCaring = false
//                    await DFMInformation.shared.setError(DFMErrorViewInfo(error: "Lost connection to the Discord Gateway.", code: .GatewayFailure))
//                }
            }
        }
    }
    
    private func heartbeatSend(heartbeatInterval: TimeInterval) {
        if socket != nil {
            let req = try! encoder.encode(DFMGatewayHeartbeat(d: heartbeatCount))
            Task {
                await self.send(req)
            }
            
            heartbeatProcess = DispatchWorkItem(block: {
                if self.heartbeatKeepCaring {
                    self.heartbeatSend(heartbeatInterval: heartbeatInterval)
                }
            })
            // send another heartbeat in heartbeatInterval seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(Int(heartbeatInterval)), execute: heartbeatProcess!)
            
            // in 5 seconds, check if a heartbeat was received. if it was not, then end.
            let heartbeatCheck = DispatchWorkItem(block: {
                if self.heartbeatKeepCaring {
                    if !self.heartbeatACK {
                        print("did not receive acknowledgement of heartbeat. now having heart attack.")
                        // TODO: Implement reconnection that doesn't give the app a heart attack.
                        // for now, unconditionally attempt reconnection.
                        Task {
                            self.heartbeatKeepCaring = false
                            await DFMInformation.shared.setError(DFMErrorViewInfo(error: "The Discord Gateway did not respond.", code: .GatewayFailure))
                            // fatalError()
                        }
                    } else {
                        self.heartbeatACK = false
                    }
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: heartbeatCheck)
        }
    }
}
