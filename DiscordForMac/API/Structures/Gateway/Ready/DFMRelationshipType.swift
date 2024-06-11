//
//  DFMRelationshipType.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

enum DFMGatewayRelationshipType: Int, Codable {
    case none = 0
    case friend = 1
    case blocked = 2
    case pendingIncoming = 3
    case pendingOutgoing = 4
    case implicit = 5
}
