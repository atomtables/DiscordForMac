//
//  DFMInformation.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 12/5/2024.
//

import Foundation
import SwiftUI

@MainActor public class DFMInformation: ObservableObject {
    
    public static var shared: DFMInformation = DFMInformation()
    
    public var gateway: DFMGatewayConnectionSocket!;
    
    internal init() {
        if !DFMConstants.DEBUG {
            self.gateway = DFMGatewayConnectionSocket()
        }
        
        return
    }
    
    @Published var loadingScreen: (Bool, String) = (true, "Initialising application")
    func setLoadingScreen(_ loadingScreen: (Bool, String)) {
        self.loadingScreen = loadingScreen
    }
    
    @Published var userInfo: DFMUser? = nil
    func setUserInfo(_ user: DFMUser) {
        self.userInfo = user
    }
    
    @Published var guildList: [DFMGuildViewData]? = nil
    func setGuildList(_ guildList: [DFMGuildViewData]) {
        self.guildList = guildList
    }
    
    @Published var error: DFMErrorViewInfo? = nil
    func setError(_ error: DFMErrorViewInfo) {
        self.error = error
    }
    
    @Published var userReferences: [Snowflake: DFMUser] = [:]
    func setUserReferences(_ userReferences: [Snowflake: DFMUser]) {
        self.userReferences = userReferences
    }
    
    @Published var privateChannels: [DFMChannel] = []
    func setPrivateChannels(_ privateChannels: [DFMChannel]) {
        self.privateChannels = privateChannels
    }
    
    @Published var presences: [DFMPresence] = []
    func setPresences(_ presences: [DFMPresence]) {
        self.presences = presences
    }
    
    @Published var subscribedChannels: Set<Snowflake> = Set()
    func setSubscribedChannels(_ channels: Set<Snowflake>) {
        self.subscribedChannels = channels
    }
    
    @Published var messages: [Snowflake: [DFMMessage]] = [:]
    func setMessages(_ messages: [Snowflake: [DFMMessage]]) {
        self.messages = messages
    }
    func addMessages(_ id: Snowflake, _ messages: [DFMMessage]) {
        // messages will always be added to the top
        if var idMs = self.messages[id] {
            idMs = messages + idMs
            self.messages[id] = idMs
        } else {
            self.messages[id] = messages
        }
    }
    
    @Published var liveMessages: [Snowflake: [DFMMessage]] = [:]
    func setLiveMessages(_ liveMessages: [Snowflake: [DFMMessage]]) {
        self.liveMessages = liveMessages
    }
    func addLiveMessages(_ id: Snowflake, _ liveMessages: [DFMMessage]) {
        // messages will always be added to the top
        if var idMs = self.liveMessages[id] {
            idMs += liveMessages
            self.liveMessages[id] = idMs
        } else {
            self.liveMessages[id] = liveMessages
        }
    }
    func addLiveMessage(_ id: Snowflake, _ liveMessage: DFMMessage) {
        if var idMs = self.liveMessages[id] {
            idMs += [liveMessage]
            self.liveMessages[id] = idMs
        } else {
            self.liveMessages[id] = [liveMessage]
        }
    }
    
    var combinedMessages: [Snowflake: [DFMMessage]] {
        return messages.merging(liveMessages) { (old, new) in
            var new = Array(new.reversed())
            new.append(contentsOf: old)
            return new
        }
    }
    
}
