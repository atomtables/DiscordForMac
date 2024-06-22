//
//  DFMChannel.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 10/5/2024.
//

import Foundation

struct DFMChannel: Codable, Identifiable, Hashable {
    let id: Snowflake
    let type: DFMChannelType
    let guildId: String?
    let position: Int?
    let permissionOverwrites: [DFMPermissionOverwrite]?
    let name: String?
    let topic: String?
    let nsfw: Bool?
    let lastMessageId: Snowflake?
    let bitrate: Int?
    let userLimit: Int?
    let rateLimitPerUser: Int?
    let recipients: [DFMUser]?
    var privateChannel: Bool = false
    var singleUserDM: Bool = false
    var groupDM: Bool { privateChannel && !singleUserDM }
    private let icon: String?
    public var groupIconURL: URL? {
        // assuming this is a private channel, as only group DMS have an icon. otherwise just put a reference to a user
        
        guard let icon = self.icon else {return nil}
        return URL(string: "\(DFMConstants.iconBaseURL)/channel-icons/\(id)/\(icon).\(icon.starts(with: "a_") ? "gif" : "png")")
    }
    let ownerId: Snowflake?
    let applicationId: String?
    let managed: Bool?
    let parentId: Snowflake?
    let lastPinTimestamp: Date? // timestamp
    let rtcRegion: String?
    let videoQualityMode: DFMVideoQualityMode?
    let messageCount: Int?
    let memberCount: Int?
    let threadMetadata: DFMThreadMetadata?
    let member: DFMThreadMember?
    let defaultAutoArchiveDuration: Int?
    let permissions: String?
    let flags: Int? // only really applies for forum channels
    let totalMessagesSent: Int?
    let availableTags: [DFMForumTag]?
    let appliedTags: [String]?
    let defaultReactionEmoji: DFMDefaultReaction?
    let defaultThreadRateLimitPerUser: Int?
    let defaultSortOrder: Int?
    let defaultForumLayout: Int?
    
    enum CodingKeys: CodingKey {
        case id, type, guildId, position, permissionOverwrites
        case name, topic, nsfw, lastMessageId, bitrate
        case userLimit, rateLimitPerUser, recipients, icon, ownerId
        case applicationId, managed, parentId, lastPinTimestamp, rtcRegion
        case videoQualityMode, messageCount, memberCount, threadMetadata, member
        case defaultAutoArchiveDuration, permissions, flags, totalMessagesSent, availableTags
        case appliedTags, defaultReactionEmoji, defaultThreadRateLimitPerUser, defaultSortOrder, defaultForumLayout
    }
    
    // for the "fake" channel placeholders
    init(id: Snowflake, name: String) {
        self.id = id
        self.name = name
        self.type = .serverChannelCategory
        
        privateChannel = false
        guildId = nil
        position = nil
        permissionOverwrites = nil
        topic = nil
        nsfw = nil
        lastMessageId = nil
        bitrate = nil
        userLimit = nil
        rateLimitPerUser = nil
        recipients = nil
        icon = nil
        ownerId = nil
        applicationId = nil
        managed = nil
        parentId = nil
        lastPinTimestamp = nil
        rtcRegion = nil
        videoQualityMode = nil
        messageCount = nil
        memberCount = nil
        threadMetadata = nil
        member = nil
        defaultAutoArchiveDuration = nil
        permissions = nil
        flags = nil // only really applies for forum channels
        totalMessagesSent = nil
        availableTags = nil
        appliedTags = nil
        defaultReactionEmoji = nil
        defaultThreadRateLimitPerUser = nil
        defaultSortOrder = nil
        defaultForumLayout = nil
    }
    
    init(id: Snowflake, name: String?, type: DFMChannelType, icon: String?, recipients: [DFMUser], lastMessageId: Snowflake?, isSpam: Bool?, flags: Int?, ownerId: Snowflake?, lastPinTimestamp: Date?) {
        self.id = id
        self.name = name
        self.type = type
        self.privateChannel = true
        self.singleUserDM = ownerId == nil ? true : false
        
        guildId = nil
        position = nil
        permissionOverwrites = nil
        topic = nil
        nsfw = nil
        self.lastMessageId = lastMessageId
        bitrate = nil
        userLimit = nil
        rateLimitPerUser = nil
        self.recipients = recipients
        self.icon = icon
        self.ownerId = ownerId
        applicationId = nil
        managed = nil
        parentId = nil
        self.lastPinTimestamp = lastPinTimestamp
        rtcRegion = nil
        videoQualityMode = nil
        messageCount = nil
        memberCount = nil
        threadMetadata = nil
        member = nil
        defaultAutoArchiveDuration = nil
        permissions = nil
        self.flags = flags // only really applies for forum channels
        totalMessagesSent = nil
        availableTags = nil
        appliedTags = nil
        defaultReactionEmoji = nil
        defaultThreadRateLimitPerUser = nil
        defaultSortOrder = nil
        defaultForumLayout = nil
    }
}

