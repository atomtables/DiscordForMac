//
//  DFMUserUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

func DFMUserUpdater() {
    NotificationCenter.default.addObserver(
        forName: Notification.Name("DFMUserUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        print("updating user")
        let obj = notification.object as? DFMGatewayUpdate
        if obj?.type == .InitialState {
            let data: DFMUser = (obj?.data as? Any) as! DFMUser
            Task {
                await DFMInformation.shared.setUserInfo(data)
            }
        }
    }
}
