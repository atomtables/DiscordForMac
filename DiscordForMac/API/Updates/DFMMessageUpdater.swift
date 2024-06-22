//
//  DFMMessageUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 05/06/2024.
//

import Foundation

func DFMMessageUpdater() {
    NotificationCenter.default.addObserver(
        forName: NSNotification.Name("DFMMessageUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        let d = notification.object as! DFMGatewayUpdate
        let message = d.data as! DFMMessage
        
        Task {
            if let privateChannel = DFMInformation.shared.privateChannels.first(where: { message.channelId == $0.id }) {
                showNotification(title: message.author?.globalName ?? message.author?.username ?? "", subtitle: privateChannel.name ?? "", body: message.content ?? "no content")
            } else if let guild = DFMInformation.shared.guildList?.first(where: { $0.guild.id == message.guildId }) {
                let channel = guild.guild.channels?.first { $0.id == message.channelId }
                showNotification(title: message.author?.globalName ?? message.author?.username ?? "", subtitle: "\(channel?.name ?? ""): \(guild.guild.name)", body: message.content ?? "no content")
            }
            
            
            
            if DFMInformation.shared.subscribedChannels.contains(message.channelId) {
                DFMInformation.shared.addLiveMessage(message.channelId, message)
            } else {
                // just ignore message, when stuff gets downloaded anyway itll come back
            }
        }
    }
}
