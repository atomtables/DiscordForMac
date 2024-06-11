//
//  DFMGuildPartial.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 9/5/2024.
//

import Foundation
/*
 /// GuildPartial is returned by the endpoint `/users/@me/guilds`.
 /// This makes it useful to get information about what servers the user is in.
 /// However, it does not return as much info as some other endpoints, which is why it is marked as partial.
 struct DFMGuild: Codable, Identifiable, Hashable {
 var id: Snowflake
 var name: String
 var icon: String?
 var iconHash: String?
 var iconURL: URL? {
 if let icon {
 return URL(string: "\(DFMConstants.iconBaseURL)/icons/\(id)/\(icon).png")
 } else if let iconHash {
 return URL(string: "\(DFMConstants.iconBaseURL)/icons/\(id)/\(iconHash).png")
 }
 return nil
 }
 var splash: String?
 var discoverySplash: String?
 var owner: Bool?
 var ownerId: Snowflake?
 var permissions: String?
 var afkChannelId: Snowflake?
 var afkTimeout: Int
 var widgetEnabled: Bool?
 var widgetChannelId: Snowflake?
 var verificationLevel: Int
 var defaultMessageNotifications: Int
 var explicitContentFilter: Int
 var features: [String]?
 var approximateMemberCount: Int
 var approximatePresenceCount: Int
 }
 */



struct DFMGuild: Codable, Identifiable, Hashable {
    var dms: Bool = false
    var user: Bool = false
    
    let id: Snowflake
    let name: String
    let icon: String?
    let iconHash: String?
    var iconURL: URL? {
        if let icon {
            if icon.starts(with: "a_") {
                return URL(string: "\(DFMConstants.iconBaseURL)/icons/\(id)/\(icon).gif")
            } else {
                return URL(string: "\(DFMConstants.iconBaseURL)/icons/\(id)/\(icon).png")
            }
        } else if let iconHash {
            if iconHash.starts(with: "a_") {
                return URL(string: "\(DFMConstants.iconBaseURL)/icons/\(id)/\(iconHash).gif")
            } else {
                return URL(string: "\(DFMConstants.iconBaseURL)/icons/\(id)/\(iconHash).png")
            }
        }
        return nil
    }
    let splash: String?
    let discoverySplash: String?
    let owner: Bool?
    let ownerId: Snowflake?
    let permissions: DFMPermission?
    let region: String?
    let afkChannelId: Snowflake?
    let afkTimeout: Int?
    let widgetEnabled: Bool?
    let widgetChannelId: Snowflake?
    let verificationLevel: Int?
    let defaultMessageNotifications: Int?
    let explicitContentFilter: Int?
    let roles: [DFMRole]?
    let emojis: [DFMEmoji]?
    let features: [DFMGuildFeature]?
    let channels: [DFMChannel]?
    let mfaLevel: Int?
    let applicationId: Snowflake?
    let systemChannelId: Snowflake?
    let systemChannelFlags: Int?
    let rulesChannelId: Snowflake?
    let maxPresences: Int?
    let maxMembers: Int?
    let vanityUrlCode: String?
    let description: String?
    let banner: String?
    let premiumTier: Int?
    let premiumSubscriptionCount: Int?
    let preferredLocale: String?
    let publicUpdatesChannelId: Snowflake?
    let maxVideoChannelUsers: Int?
    let maxStageVideoChannelUsers: Int?
    let approximateMemberCount: Int?
    let approximatePresenceCount: Int?
    let welcomeScreen: DFMWelcomeScreen?
    let nsfwLevel: Int?
    let stickers: [DFMSticker]?
    let premiumProgressBarEnabled: Bool?
    let safetyAlertsChannelId: Snowflake?
    
    init(id: Snowflake, dms: Bool) {
        self.id = id
        self.name = "Direct Messages"
        self.dms = true
        
        self.icon = nil
        self.iconHash = nil
        self.splash = nil
        self.discoverySplash = nil
        self.owner = nil
        self.ownerId = nil
        self.permissions = nil
        self.region = nil
        self.afkChannelId = nil
        self.afkTimeout = nil
        self.widgetEnabled = nil
        self.widgetChannelId = nil
        self.verificationLevel = nil
        self.defaultMessageNotifications = nil
        self.explicitContentFilter = nil
        self.roles = nil
        self.emojis = nil
        self.features = nil
        self.mfaLevel = nil
        self.applicationId = nil
        self.systemChannelId = nil
        self.systemChannelFlags = nil
        self.rulesChannelId = nil
        self.maxPresences = nil
        self.maxMembers = nil
        self.vanityUrlCode = nil
        self.description = nil
        self.banner = nil
        self.premiumTier = nil
        self.premiumSubscriptionCount = nil
        self.preferredLocale = nil
        self.publicUpdatesChannelId = nil
        self.maxVideoChannelUsers = nil
        self.maxStageVideoChannelUsers = nil
        self.approximateMemberCount = nil
        self.approximatePresenceCount = nil
        self.welcomeScreen = nil
        self.nsfwLevel = nil
        self.stickers = nil
        self.premiumProgressBarEnabled = nil
        self.safetyAlertsChannelId = nil
        self.channels = nil
    }
    init(id: Snowflake, user: Bool) {
        self.id = id
        self.name = "User"
        self.user = true
        
        self.icon = nil
        self.iconHash = nil
        self.splash = nil
        self.discoverySplash = nil
        self.owner = nil
        self.ownerId = nil
        self.permissions = nil
        self.region = nil
        self.afkChannelId = nil
        self.afkTimeout = nil
        self.widgetEnabled = nil
        self.widgetChannelId = nil
        self.verificationLevel = nil
        self.defaultMessageNotifications = nil
        self.explicitContentFilter = nil
        self.roles = nil
        self.emojis = nil
        self.features = nil
        self.mfaLevel = nil
        self.applicationId = nil
        self.systemChannelId = nil
        self.systemChannelFlags = nil
        self.rulesChannelId = nil
        self.maxPresences = nil
        self.maxMembers = nil
        self.vanityUrlCode = nil
        self.description = nil
        self.banner = nil
        self.premiumTier = nil
        self.premiumSubscriptionCount = nil
        self.preferredLocale = nil
        self.publicUpdatesChannelId = nil
        self.maxVideoChannelUsers = nil
        self.maxStageVideoChannelUsers = nil
        self.approximateMemberCount = nil
        self.approximatePresenceCount = nil
        self.welcomeScreen = nil
        self.nsfwLevel = nil
        self.stickers = nil
        self.premiumProgressBarEnabled = nil
        self.safetyAlertsChannelId = nil
        self.channels = nil
    }
    
    init(
        id: Snowflake,
        name: String,
        icon: String?,
        iconHash: String?,
        splash: String?,
        discoverySplash: String?,
        owner: Bool?,
        ownerId: Snowflake?,
        permissions: DFMPermission?,
        region: String?,
        afkChannelId: Snowflake?,
        afkTimeout: Int?,
        widgetEnabled: Bool?,
        widgetChannelId: Snowflake?,
        verificationLevel: Int?,
        defaultMessageNotifications: Int?,
        explicitContentFilter: Int?,
        roles: [DFMRole]?,
        emojis: [DFMEmoji]?,
        features: [DFMGuildFeature]?,
        channels: [DFMChannel]?,
        mfaLevel: Int?,
        applicationId: Snowflake?,
        systemChannelId: Snowflake?,
        systemChannelFlags: Int?,
        rulesChannelId: Snowflake?,
        maxPresences: Int?,
        maxMembers: Int?,
        vanityUrlCode: String?,
        description: String?,
        banner: String?,
        premiumTier: Int?,
        premiumSubscriptionCount: Int?,
        preferredLocale: String?,
        publicUpdatesChannelId: Snowflake?,
        maxVideoChannelUsers: Int?,
        maxStageVideoChannelUsers: Int?,
        approximateMemberCount: Int?,
        approximatePresenceCount: Int?,
        welcomeScreen: DFMWelcomeScreen?,
        nsfwLevel: Int?,
        stickers: [DFMSticker]?,
        premiumProgressBarEnabled: Bool?,
        safetyAlertsChannelId: Snowflake?
    ) {
        self.id = id
        self.name = name
        
        self.icon = icon
        self.iconHash = iconHash
        self.splash = splash
        self.discoverySplash = discoverySplash
        self.owner = owner
        self.ownerId = ownerId
        self.permissions = permissions
        self.region = region
        self.afkChannelId = afkChannelId
        self.afkTimeout = afkTimeout
        self.widgetEnabled = widgetEnabled
        self.widgetChannelId = widgetChannelId
        self.verificationLevel = verificationLevel
        self.defaultMessageNotifications = defaultMessageNotifications
        self.explicitContentFilter = explicitContentFilter
        self.roles = roles
        self.emojis = emojis
        self.features = features
        self.mfaLevel = mfaLevel
        self.applicationId = applicationId
        self.systemChannelId = systemChannelId
        self.systemChannelFlags = systemChannelFlags
        self.rulesChannelId = rulesChannelId
        self.maxPresences = maxPresences
        self.maxMembers = maxMembers
        self.vanityUrlCode = vanityUrlCode
        self.description = description
        self.banner = banner
        self.premiumTier = premiumTier
        self.premiumSubscriptionCount = premiumSubscriptionCount
        self.preferredLocale = preferredLocale
        self.publicUpdatesChannelId = publicUpdatesChannelId
        self.maxVideoChannelUsers = maxVideoChannelUsers
        self.maxStageVideoChannelUsers = maxStageVideoChannelUsers
        self.approximateMemberCount = approximateMemberCount
        self.approximatePresenceCount = approximatePresenceCount
        self.welcomeScreen = welcomeScreen
        self.nsfwLevel = nsfwLevel
        self.stickers = stickers
        self.premiumProgressBarEnabled = premiumProgressBarEnabled
        self.safetyAlertsChannelId = safetyAlertsChannelId
        self.channels = channels
    }
    
    enum CodingKeys: CodingKey {
        case id, name, icon, iconHash, splash, discoverySplash, owner, ownerId, permissions, region, afkChannelId, afkTimeout, widgetEnabled, widgetChannelId, verificationLevel, defaultMessageNotifications, explicitContentFilter, roles, emojis, features, mfaLevel, applicationId, systemChannelId, systemChannelFlags, rulesChannelId, maxPresences, maxMembers, vanityUrlCode, description, banner, premiumTier, premiumSubscriptionCount, preferredLocale, publicUpdatesChannelId, maxVideoChannelUsers, maxStageVideoChannelUsers, approximateMemberCount, approximatePresenceCount, welcomeScreen, nsfwLevel, stickers, premiumProgressBarEnabled, safetyAlertsChannelId, channels
    }
}
