//
//  DFMGatewayHeartbeat.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/05/2024.
//

import Foundation

public struct DFMGatewayHeartbeat: Codable {
    var op: Int = 1
    @CodableExplicitNull var d: Int?
}
