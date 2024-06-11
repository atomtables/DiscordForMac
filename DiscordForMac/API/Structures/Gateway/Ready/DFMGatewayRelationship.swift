//
//  DFMGatewayRelationship.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

struct DFMGatewayRelationship: Codable, Hashable {
    var type: DFMGatewayRelationshipType
    var userId: Snowflake
    var id: Snowflake? // usually duplicate of userId
    var since: String?
    var nickname: String?
}

