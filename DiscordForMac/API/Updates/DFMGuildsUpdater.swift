//
//  DFMGuildsUpdater.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

func DFMGuildsUpdater() {
    NotificationCenter.default.addObserver(
        forName: Notification.Name("DFMGuildsUpdate"),
        object: nil,
        queue: nil
    ) { notification in
        print("updating guilds")
        let obj = notification.object as? DFMGatewayUpdate
        if obj?.type == .InitialState {
            let data: [DFMGatewayGuild] = (obj?.data as! [DFMGatewayGuild])
            
            let guilds: [DFMGuildViewData] = data.map { gatewayGuild in
                var guildChannels: [DFMChannelViewData] = []
                
                let categories = gatewayGuild.channels.compactMap { channel in
                    return channel.type == .serverChannelCategory ? channel : nil
                }.sorted {
                    $0.position ?? 0 < $1.position ?? 0
                }
                
                var remaining: [DFMChannel] = Array(Set(gatewayGuild.channels).subtracting(categories))
                
                for category in categories {
                    var channels = gatewayGuild.channels.compactMap { channel in
                        return channel.parentId == category.id ? channel : nil
                    }
                    
                    remaining = Array(Set(remaining).subtracting(channels))
                    
                    channels.sort {
                        $0.position! < $1.position!
                    }
                    
                    guildChannels.append(DFMChannelViewData(category: category, channels: channels))
                }
                
                guildChannels.insert(DFMChannelViewData(category: DFMChannel(id: Snowflake(0), name: "   Unlabeled Channels"), channels: remaining.sorted {$0.position! < $1.position!}), at: 0)
                
                let guild = DFMGuild(
                    id: gatewayGuild.id,
                    name: gatewayGuild.properties.name,
                    icon: gatewayGuild.properties.icon,
                    iconHash: gatewayGuild.properties.icon,
                    splash: gatewayGuild.properties.splash,
                    discoverySplash: gatewayGuild.properties.discoverySplash,
                    owner: nil,
                    ownerId: gatewayGuild.properties.ownerId,
                    permissions: nil,
                    region: nil,
                    afkChannelId: gatewayGuild.properties.afkChannelId,
                    afkTimeout: nil,
                    widgetEnabled: nil,
                    widgetChannelId: nil,
                    verificationLevel: gatewayGuild.properties.verificationLevel, 
                    defaultMessageNotifications: nil,
                    explicitContentFilter: gatewayGuild.properties.explicitContentFilter,
                    roles: gatewayGuild.roles, 
                    emojis: gatewayGuild.emojis,
                    features: gatewayGuild.properties.features,
                    channels: gatewayGuild.channels,
                    mfaLevel: gatewayGuild.properties.mfaLevel,
                    applicationId: nil,
                    systemChannelId: gatewayGuild.properties.systemChannelId,
                    systemChannelFlags: gatewayGuild.properties.systemChannelFlags,
                    rulesChannelId: gatewayGuild.properties.rulesChannelId,
                    maxPresences: nil, maxMembers: gatewayGuild.properties.maxMembers,
                    vanityUrlCode: gatewayGuild.properties.vanityUrlCode,
                    description: gatewayGuild.properties.description,
                    banner: gatewayGuild.properties.banner,
                    premiumTier: nil,
                    premiumSubscriptionCount: nil,
                    preferredLocale: gatewayGuild.properties.preferredLocale,
                    publicUpdatesChannelId: gatewayGuild.properties.publicUpdatesChannelId,
                    maxVideoChannelUsers: nil,
                    maxStageVideoChannelUsers: nil,
                    approximateMemberCount: gatewayGuild.memberCount,
                    approximatePresenceCount: nil,
                    welcomeScreen: nil,
                    nsfwLevel: gatewayGuild.properties.nsfwLevel,
                    stickers: gatewayGuild.stickers,
                    premiumProgressBarEnabled: nil, 
                    safetyAlertsChannelId: nil
                )
                
                return DFMGuildViewData(guild: guild, categoryOrganisedChannels: guildChannels)
            }
            
            Task {
                await DFMInformation.shared.setGuildList(guilds)
            }
        }
    }
}
