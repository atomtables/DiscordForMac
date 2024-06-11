//
//  DFMGatewayServerHello.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/05/2024.
//

import Foundation

public struct DFMGatewayServerHello: Codable {
    var op: Int
    var d: DFMGatewayHeartbeatInterval
}

public struct DFMGatewayHeartbeatInterval: Codable {
    var heartbeatInterval: Double
}
