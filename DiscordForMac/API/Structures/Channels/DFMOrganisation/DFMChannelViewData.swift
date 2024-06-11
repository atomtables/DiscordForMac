//
//  DFMChannelViewData.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 16/05/2024.
//

import Foundation

struct DFMChannelViewData: Codable, Hashable {
    var category: DFMChannel // type = 4
    var channels: [DFMChannel] // other ones
}
