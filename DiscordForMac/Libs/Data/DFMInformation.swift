//
//  DFMInformation.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 12/5/2024.
//

import Foundation
import SwiftUI
import KeychainAccess

public class DFMInformation: ObservableObject {
    
    public static var shared: DFMInformation = DFMInformation()
    
    public var gateway: DFMGatewayConnectionSocket!;
    
    internal init() {
        self.gateway = DFMGatewayConnectionSocket()
        return
    }
    
    @Published var loadingScreen: (Bool, String) = (true, "Initialising application")

    @Published var userInfo: DFMUser? = nil
    
    @Published var guildList: [DFMGuildViewData]? = nil
    
    @Published var error: DFMErrorViewInfo? = nil
    
    @Published var userReferences: [Snowflake: DFMUser] = [:]
    
    @Published var privateChannels: [DFMChannel] = []
    
    @Published var presences: [DFMPresence] = []
    
    @Published var subscribedChannels: Set<Snowflake> = Set()
    
    @Published var messages: [Snowflake: [DFMMessage]] = [:]
    
    @Published var liveMessages: [Snowflake: [DFMMessage]] = [:]
    
    var combinedMessages: [Snowflake: [DFMMessage]] {
        withAnimation {
            return messages.merging(liveMessages) { (old, new) in
                var new = new
                new.append(contentsOf: old)
                return new
            }
        }
    }
    
    @Published var isWindowFocused: Bool = false
    
    @Published var shouldShowAccountChooser: Bool = false

    @Published var shouldChangeAccount: Bool = false

    @Published var keychainItems: [[String]] = []

    @Published var keychain = Keychain(service: "dev.atomtables.DiscordForMac")

    @Published var shouldLogOut: (Bool, String?) = (false, nil)
    @Published var shouldAddNewAccount: (Bool, String?) = (false, nil)

    func addMessages(_ id: Snowflake, _ messages: [DFMMessage]) {
        DispatchQueue.main.async {
            // messages will always be added to the top
            if var idMs = self.messages[id] {
                idMs += messages
                self.messages[id] = idMs
            } else {
                self.messages[id] = messages
            }
        }
    }
    func addLiveMessages(_ id: Snowflake, _ liveMessages: [DFMMessage]) {
        // messages will always be added to the top
        if var idMs = self.liveMessages[id] {
            idMs = liveMessages + idMs
            self.liveMessages[id] = idMs
        } else {
            self.liveMessages[id] = liveMessages
        }
    }
    func addLiveMessage(_ id: Snowflake, _ liveMessage: DFMMessage) {
        DispatchQueue.main.async {
            if var idMs = self.liveMessages[id] {
                idMs = [liveMessage] + idMs
                self.liveMessages[id] = idMs
            } else {
                self.liveMessages[id] = [liveMessage]
            }
        }
    }
}
