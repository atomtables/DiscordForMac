//
//  DFMGatewayServerReadySupplemental.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 02/06/2024.
//

import Foundation

struct DFMGatewayServerReadySupplemental: Codable {
    let d: DFMGatewayServerReadySupplementalStructure
}

struct DFMGatewayServerReadySupplementalStructure: Codable {
    let mergedPresences: DFMGatewayServerReadySupplementalMergedPresences
    // theres at least 5 more values that can be looked at later
}

struct DFMGatewayServerReadySupplementalMergedPresences: Codable {
    let friends: [DFMGatewayServerReadySupplementalFriendPresences]
}

struct DFMGatewayServerReadySupplementalFriendPresences: Codable {
    let userId: Snowflake
    let status: DFMPresenceStatus
    let clientStatus: DFMPresenceClientStatus
    let activities: [DFMActivity]
}
