//
//  DFMGatewayUpdate.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

struct DFMGatewayUpdate {
    var type: DFMGatewayUpdateType
    var data: any Codable
}

enum DFMGatewayUpdateType {
    case InitialState
    case UpdateState
}
