//
//  DFMPresencesUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 02/06/2024.
//

import Foundation

enum DFMError: Error {
    case thrownError(String)
}

func DFMPresencesUpdater() {
    NotificationCenter.default.addObserver(
        forName: NSNotification.Name("DFMPresencesUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        let object = notification.object as! DFMGatewayUpdate
        let gatewayPresences = object.data as! [DFMGatewayServerReadySupplementalFriendPresences]
        // map this to regular presences
        Task {
            let userDict = await DFMInformation.shared.userReferences
            
            let presences: [DFMPresence] = gatewayPresences.compactMap { presence in
                do {
                    return DFMPresence(
                        user: try DFMPresencesCheckUserFound(userDict, presence),
                        status: presence.status,
                        clientStatus: presence.clientStatus, 
                        activities: presence.activities
                    )
                } catch {
                    return nil
                }
            }
            
            await DFMInformation.shared.setPresences(presences)
        }
    }
    
    @Sendable func DFMPresencesCheckUserFound(_ userDict: [Snowflake: DFMUser], _ presence: DFMGatewayServerReadySupplementalFriendPresences) throws -> DFMUser {
        let p = userDict.first { id, user in
            presence.userId == id
        }.map { id, user in
            return user
        }
        if p == nil {
            throw DFMError.thrownError("nil found")
        } else {
            return p!
        }
    }
}
