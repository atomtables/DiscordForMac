//
//  DFMPrivateChannelsUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 17/05/2024.
//

import Foundation

func DFMPrivateChannelsUpdater() async {
    
    NotificationCenter.default.addObserver(
        forName: Notification.Name("DFMPrivateChannelsUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        PrintDebug("updating private channels")
        let obj = notification.object as? DFMGatewayUpdate
        DispatchQueue.main.async {
            if obj?.type == .InitialState {
                let data: [DFMGatewayPrivateChannel] = (obj?.data as? Any) as! [DFMGatewayPrivateChannel]
                
                let userReferences = DFMInformation.shared.userReferences
                
                let channels: [DFMChannel] = data.map { channel in
                    return DFMChannel(
                        id: channel.id,
                        name: channel.name,
                        type: channel.type, // 1
                        icon: channel.icon,
                        recipients: channel.recipientIds.map { recipientId in
                            return userReferences[recipientId]!
                        },
                        lastMessageId: channel.lastMessageId,
                        isSpam: channel.isSpam,
                        flags: channel.flags,
                        ownerId: channel.ownerId, 
                        lastPinTimestamp: channel.lastPinTimestamp
                    )
                }.sorted {
                    $0.lastMessageId?.toDate() ?? Date(timeIntervalSince1970: 0)
                    > $1.lastMessageId?.toDate() ?? Date(timeIntervalSince1970: 0)
                }
                
                DFMInformation.shared.privateChannels = channels
            }
        }
    }
}
