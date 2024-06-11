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
            if await DFMInformation.shared.subscribedChannels.contains(message.channelId) {
                await DFMInformation.shared.addLiveMessage(message.channelId, message)
            } else {
                // just ignore message, when stuff gets downloaded anyway itll come back
            }
        }
    }
}
