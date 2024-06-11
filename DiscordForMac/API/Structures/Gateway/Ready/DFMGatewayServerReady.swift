//
//  DFMGatewayServerReady.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

struct DFMGatewayServerReady: Codable {
    var d: DFMGatewayServerReadyStructure
}

struct DFMGatewayServerReadyStructure: Codable {
    var v: Int // api version
    var users: [DFMUser] // idk where this comes from, supposedly just a list of a bunch of online users
    var user: DFMUser // own user
    var sessionId: String
    var resumeGatewayUrl: String
    var relationships: [DFMGatewayRelationship]
    var privateChannels: [DFMGatewayPrivateChannel]
    var guilds: [DFMGatewayGuild]
}

struct DFMGatewayPrivateChannel: Codable {
    var name: String?
    var icon: String?
    var type: DFMChannelType
    var recipientIds: [Snowflake]
    var lastMessageId: Snowflake?
    var isSpam: Bool?
    var id: Snowflake
    var flags: Int?
    var ownerId: Snowflake?
    var lastPinTimestamp: String?
}

struct DFMGatewayGuild: Codable {
    var version: Int // timestamp
    // var threads: Unimplemented
    var stickers: [DFMSticker]
    // var stage_instances: Unimplemented
    var roles: [DFMRole]
    var channels: [DFMChannel]
    var emojis: [DFMEmoji]
    var properties: DFMGatewayGuildProperties
    var memberCount: Int
    var lazy: Bool?
    var large: Bool?
    var joinedAt: String?
    var id: Snowflake
}

struct DFMGatewayGuildProperties: Codable {
    // missing a bunch of values, look back later if something isnt working lmao
    var verificationLevel: Int
    var banner: String?
    var discoverySplash: String?
    var nsfw: Bool?
    var systemChannelFlags: Int?
    var mfaLevel: Int?
    var id: Snowflake
    var maxMembers: Int
    var name: String
    var preferredLocale: String?
    var icon: String?
    var systemChannelId: Snowflake?
    var rulesChannelId: Snowflake?
    var description: String?
    var publicUpdatesChannelId: Snowflake?
    var vanityUrlCode: String?
    var ownerId: Snowflake
    var splash: String?
    var afkChannelId: Snowflake?
    var features: [DFMGuildFeature]
    var explicitContentFilter: Int?
    var nsfwLevel: Int?
}


