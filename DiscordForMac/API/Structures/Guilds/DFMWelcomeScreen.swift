//
//  DFMWelcomeScreen.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMWelcomeScreen: Codable, Hashable {
    var description: String?
    var welcomeChannels: [DFMWelcomeScreenChannels]
}

struct DFMWelcomeScreenChannels: Codable, Hashable {
    var channelId: Snowflake
    var description: String
    var emojiId: Snowflake?
    var emojiName: String?
}
