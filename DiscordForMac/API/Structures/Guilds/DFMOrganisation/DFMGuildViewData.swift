//
//  DFMGuildViewData.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 16/05/2024.
//

import Foundation

struct DFMGuildViewData: Codable, Hashable {
    var guild: DFMGuild
    var categoryOrganisedChannels: [DFMChannelViewData]
}
