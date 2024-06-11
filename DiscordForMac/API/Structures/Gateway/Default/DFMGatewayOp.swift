//
//  DFMGatewayOp.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/05/2024.
//

import Foundation

/// This only contains the opcode section.
/// This is because each gateway exit point has a lot of different types it could be.
/// As such, this contains the minimal amount of data required to identify something.
/// T and S are optional, so each will be based on their value for D.
struct DFMGatewayOp: Codable {
    var op: DFMGatewayOpCode
    var t: DFMGatewayDispatchEventType?
    var s: Int?
}

enum DFMGatewayOpCode: Int, Codable {
    case dispatch = 0
    case heartbeat = 1
    case identify = 2
    case presenceUpdate = 3
    case voiceStateUpdate = 4
    case resume = 6
    case reconnect = 7
    case requestGuildMembers = 8
    case invalidSession = 9
    case hello = 10
    case heartbeatAck = 11
}

enum DFMGatewayDispatchEventType: String, Codable, CaseIterableDefaultsLast {
    case Ready = "READY"
    case ReadySupplemental = "READY_SUPPLEMENTAL"
    case UserUpdate = "USER_UPDATE"
    case GuildCreate = "GUILD_CREATE"
    case GuildUpdate = "GUILD_UPDATE"
    case GuildDelete = "GUILD_DELETE"
    case ChannelCreate = "CHANNEL_CREATE"
    case ChannelUpdate = "CHANNEL_UPDATE"
    case ChannelDelete = "CHANNEL_DELETE"
    case MessageCreate = "MESSAGE_CREATE"
    case MessageUpdate = "MESSAGE_UPDATE"
    case MessageDelete = "MESSAGE_DELETE"
    case MessageAck = "MESSAGE_ACK"
    case MessageReactionAdd = "MESSAGE_REACTION_ADD"
    case MessageReactionRemove = "MESSAGE_REACTION_REMOVE"
    case MessageReactionRemoveAll = "MESSAGE_REACTION_REMOVE_ALL"
    case SessionsReplace = "SESSIONS_REPLACE"
    case GuildMemberChunk = "GUILD_MEMBER_CHUNK"
    case UserSettingsUpdate = "USER_SETTINGS_UPDATE"
    case UserSettingsProtoUpdate = "USER_SETTINGS_PROTO_UPDATE"
    case PresenceUpdate = "PRESENCE_UPDATE"
    case Unknown
}
