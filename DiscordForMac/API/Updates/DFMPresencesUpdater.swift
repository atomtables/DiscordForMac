//
//  DFMPresencesUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 02/06/2024.
//

import Foundation

enum DFMError: Error {
    case thrownError(String)
    case shownError(DFMErrorPriority, String)
    case internalError(Int, DFMErrorPriority, String)
}

enum DFMErrorPriority {
    case info
    case warning
    case critical
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
        DispatchQueue.main.async {
            let userDict = DFMInformation.shared.userReferences
            
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
            
            DFMInformation.shared.presences = presences
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
