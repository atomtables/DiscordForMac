//
//  DFMUserReferenceUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 16/05/2024.
//

import Foundation

func DFMUserReferenceUpdater() async {
    
    NotificationCenter.default.addObserver(
        forName: Notification.Name("DFMUserReferencesUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        print("updating userreferences")
        let obj = notification.object as? DFMGatewayUpdate
        if obj?.type == .InitialState {
            let data: [Snowflake: DFMUser] = obj?.data as! [Snowflake: DFMUser]
            Task {
                await DFMInformation.shared.setUserReferences(data)
            }
        }
    }
}
