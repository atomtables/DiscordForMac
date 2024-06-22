//
//  DFMGatewayConnectionSocket.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/05/2024.
//

import Foundation

public class DFMGatewayConnectionSocket {
    private var newRequestNum: Int = 0
    
    private var socket: URLSessionWebSocketTask!
    
    private var receiveInfiniteProcess: DispatchWorkItem?
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private let instanceNonce: UInt32
    
    private var heartbeatInterval: Double?
    private var heartbeatCount: Int?
    private var heartbeatProcess: DispatchWorkItem?
    private var heartbeatKeepCaring: Bool = true
    private var heartbeatACK: Bool = true

    private var sessionID: String = ""
    private var resumeGatewayURL: String = ""
    
    internal init() {
        self.instanceNonce = arc4random()
        
        self.encoder = DFMConstants.encoder
        self.decoder = DFMConstants.decoder
    }

    public func isSocketConnected() {
        
    }

    public func start() {
        self.stop()

        DispatchQueue.main.async {
            DFMInformation.shared.loadingScreen = (true, "Connecting to the server")
        }

        socket = URLSession.shared.webSocketTask(with: URL(string: "wss://gateway.discord.gg/?v=10&encoding=json")!)
        socket.maximumMessageSize = 149357600
        socket.resume()
        self.heartbeatKeepCaring = true
        self.heartbeatACK = true
        self.newRequestNum = 0
        
        // start with the infinite receiving loop
        self.receive()
    }
    
    public func stop() {
        self.heartbeatKeepCaring = false
        self.heartbeatACK = true
        heartbeatProcess?.cancel()
        receiveInfiniteProcess?.cancel()
        
        if socket != nil {
            socket.cancel(with: .goingAway, reason: .none)
        }
        socket = nil
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
    
    private func processInput(_ data: Data) {
        newRequestNum += 1
        do {
            let op = try decoder.decode(DFMGatewayOp.self, from: data)
            if let s = op.s {
                if s > (heartbeatCount ?? 0) {
                    heartbeatCount = s
                }
            }
            PrintDebug("new op: \(String(describing: op.t))")
            if op.op == .heartbeat {
                PrintDebug("heartbeat was received")
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
//                PrintDebug("recieved opcode 0. *to be implemented*")
                // send notification center event listeners to handle these on other files
                switch op.t {
                case .Ready:
                    PrintDebug("received a ready event")
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
                
                    DispatchQueue.main.async { DFMInformation.shared.loadingScreen = (false, "Success") }
                case .ReadySupplemental:
                    PrintDebug("got ready supplemental data")
                    let d = try decoder.decode(DFMGatewayServerReadySupplemental.self, from: data)
                    let dd = d.d
                    
                    let presenceData = DFMGatewayUpdate(type: .InitialState, data: dd.mergedPresences.friends)
                    NotificationCenter.default.post(name: Notification.Name("DFMPresencesUpdate"), object: presenceData)
                case .MessageCreate:
                    let d = try decoder.decode(DFMGatewayServerMessage.self, from: data)
                    let dd = d.d
                    
                    PrintDebug("new message: \(dd)")

                    let messageData = DFMGatewayUpdate(type: .UpdateState, data: dd)
                    NotificationCenter.default.post(name: Notification.Name("DFMMessageUpdate"), object: messageData)
                default:
                    PrintDebug("unknown op type")
                    PrintDebug(String(data: data, encoding: .utf8)!)
                }
            } else if op.op == .hello {
                PrintDebug("got hello message")
                DispatchQueue.main.async { DFMInformation.shared.loadingScreen = (true, "Authenticating") }
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
                PrintDebug("heartbeat ack received")
                self.heartbeatACK = true
            } else {
                PrintDebug("what : (nothing matches): Op \(op.op)")
            }
        } catch {
            PrintDebug("Unexpected inability to decode... \(error)")
            PrintDebug(String(data: data, encoding: .utf8)!)
            fatalError()
        }
    }
    
    private func identify() {
        let req = try! encoder.encode(DFMGatewayClientIdentify())
        Task {
            await self.send(req)
        }
        DispatchQueue.main.async { DFMInformation.shared.loadingScreen = (true, "Waiting for server data") }
    }
    
    private func resume() {
        // assume this was only received because of a resumable connection.
        // since socket is dead, redefine socket
        self.socket = URLSession.shared.webSocketTask(with: URL(string: "wss://gateway.discord.gg/?v=10&encoding=json")!)
    }
    
    public func send(_ data: Data) async {
        PrintDebug("sending data right now")
//        PrintDebug(String(data: data, encoding: .utf8)!)
        let dataToSend = URLSessionWebSocketTask.Message.data(data)
        
        do {
            try await socket.send(dataToSend)
        } catch {
            PrintDebug("\(instanceNonce): failed sending data \(data): \(error)")
            // failed to send usually means somethings up, so let it slide
        }
    }
    
    private func receive() {
        socket.receive { result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    self.processInput(data)
                    self.receiveInfiniteProcess = DispatchWorkItem(block: {
                        self.receive()
                    })
                    DispatchQueue.main.async(execute: self.receiveInfiniteProcess!)
                case .string(let text):
                    self.processInput(text.data(using: .utf8)!)
                    self.receiveInfiniteProcess = DispatchWorkItem(block: {
                        self.receive()
                    })
                    DispatchQueue.main.async(execute: self.receiveInfiniteProcess!)
                @unknown default:
                    PrintDebug("weird new type of output that shouldn't exist. call it a bug and fix it later.")
                    fatalError()
                }
            case .failure(let error):
                if self.heartbeatKeepCaring {
                    PrintDebug("Error when receiving: \(error)")
                    PrintDebug("time: \(Date())")

                    DispatchQueue.main
                        .async {
                            DFMInformation.shared.error = DFMErrorViewInfo(
                                error: "Failed to maintain a connection with Discord.",
                                code: .InternetFailure,
                                fatal: true
                            )
                        }
                    self.heartbeatKeepCaring = false
                }
            }
        }
    }
    
    private func heartbeatSend(heartbeatInterval: TimeInterval) {
        PrintDebug("sending heartbeat")
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
            
            if self.heartbeatKeepCaring {
                if !self.heartbeatACK {
                    PrintDebug("did not receive acknowledgement of heartbeat. now having heart attack.")
                    // TODO: Implement reconnection that doesn't give the app a heart attack.
                    // for now, unconditionally attempt reconnection.
                    DispatchQueue.main.async {
                        self.heartbeatKeepCaring = false
                        DFMInformation.shared.error = DFMErrorViewInfo(error: "The Discord Gateway did not respond.", code: .GatewayFailure)
                        // fatalError()
                    }
                } else {
                    PrintDebug("last heartbeat acknowledged")
                    self.heartbeatACK = false
                }
            }
        }
    }
}
