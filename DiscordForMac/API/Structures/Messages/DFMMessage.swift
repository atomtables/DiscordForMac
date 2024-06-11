//
//  DFMMessage.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 23/05/2024.
//

import Foundation

enum DFMMessageType: Int, Codable {
    case defaultType = 0
    case recipientAdd = 1
    case recipientRemove = 2
    case call = 3
    case channelNameChange = 4
    case channelIconChange = 5
    case channelPinnedMessage = 6
    case userJoin = 7
    case guildBoost = 8
    case guildBoostTier1 = 9
    case guildBoostTier2 = 10
    case guildBoostTier3 = 11
    case channelFollowAdd = 12
    case guildDiscoveryDisqualified = 14
    case guildDiscoveryRequalified = 15
    case guildDiscoveryGracePeriodInitialWarning = 16
    case guildDiscoveryGracePeriodFinalWarning = 17
    case threadCreated = 18
    case reply = 19
    case chatInputCommand = 20
    case threadStarterMessage = 21
    case guildInviteReminder = 22
    case contextMenuCommand = 23
    case autoModerationAction = 24
    case roleSubscriptionPurchase = 25
    case interactionPremiumUpsell = 26
    case stageStart = 27
    case stageEnd = 28
    case stageSpeaker = 29
    case stageTopic = 31
    case guildApplicationPremiumSubscription = 32
}

enum DFMMessageActivityType: Int, Codable {
    case join = 1
    case spectate = 2
    case listen = 3
    case joinRequest = 5
}

struct DFMMessageFlags: Codable, CustomStringConvertible, Hashable {
    let int: Int64
    var uint: UInt64 {
        UInt64(int)
    }
    
    init(_ value: Int64) {
        self.int = value
    }
    
    init(_ value: String) throws {
        self.int = Int64(value)!
    }
    
    var description: String {
        return "\(int)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            int = try container.decode(Int64.self)
        } catch {
            let string = try container.decode(String.self)
            int = Int64(string)!
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(int)
    }
    
    func toSet() -> Set<DFMMessageFlagsType> {
        var set = Set<DFMMessageFlagsType>()
        
        for flag in DFMMessageFlagsType.allCases {
            if (uint & flag.rawValue) == flag.rawValue {
                set.insert(flag)
            }
        }
        
        return set
    }
}

enum DFMMessageFlagsType: UInt64, Codable, CaseIterable {
    case crossposted = 1
    case isCrosspost = 2
    case suppressEmbeds = 4
    case sourceMessageDeleted = 8
    case urgent = 16
    case hasThread = 32
    case ephemeral = 64
    case loading = 128
    case failedToMentionSomeRolesInThread = 256
    case suppressNotifications = 4096
    case isVoiceMessage = 8192
}

struct DFMAttachment: Codable {
    let id: String
    let filename: String
    let size: Int
    let url: String
    let proxyUrl: String
    let height: Int?
    let width: Int?
    let contentType: String?
}

struct DFMReaction: Codable {
    let count: Int
    let me: Bool
    let emoji: DFMEmoji
}

struct DFMMessageActivity: Codable {
    let type: DFMMessageActivityType
    let partyId: String?
}

struct DFMMessageReference: Codable {
    let messageId: String?
    let channelId: String?
    let guildId: String?
}

struct DFMEmbedFooter: Codable {
    let name: String?
    let value: String?
    let inline: Bool?
}

struct DFMEmbedImage: Codable {
    let url: String
    var urlURL: URL {
        return URL(string: url)!
    }
    let proxyUrl: String?
    let height: Int?
    let width: Int?
}

struct DFMEmbedThumbnail: Codable {
    let url: String
    var urlURL: URL {
        return URL(string: url)!
    }
    let proxyUrl: String?
    let height: Int?
    let width: Int?
}

struct DFMEmbedVideo: Codable {
    let url: String?
    var urlURL: URL? {
        return URL(string: url ?? "")
    }
    let proxyUrl: String?
    let height: Int?
    let width: Int?
}

struct DFMEmbedProvider: Codable {
    let name: String?
    let url: String?
}

struct DFMEmbedAuthor: Codable {
    let name: String
    let url: String?
    var urlURL: URL? {
        return URL(string: url ?? "")
    }
    let iconUrl: String?
    var iconURL: URL? {
        return URL(string: iconUrl ?? "")
    }
    let proxyIconUrl: String?
}

struct DFMEmbedField: Codable {
    let name: String
    let value: String
    let inline: Bool?
}

struct DFMEmbed: Codable {
    let title: String?
    let type: String? // deprecated
    let description: String?
    let url: String?
    let timestamp: String? // date
    let color: Int?
    let footer: DFMEmbedFooter?
    let image: DFMEmbedImage?
    let thumbnail: DFMEmbedThumbnail?
    let video: DFMEmbedVideo?
    let provider: DFMEmbedProvider?
    let author: DFMEmbedAuthor?
    let fields: [DFMEmbedField]?
}

enum DFMMessageInteractionType: Int, Codable {
    case ping = 1
    case applicationCommand = 2
    case messageComponent = 3
    case applicationCommandAutocomplete = 4
    case modalSubmit = 5
}

enum DFMApplicationIntegrationType: Int, Codable {
    case guildInstall = 0
    case userInstall = 1
}

class DFMMessageInteractionMetadata: Codable {
    let id: Snowflake
    let type: DFMMessageInteractionType
    let user: DFMUser
    // let authorizingIntegrationOwners: some dictionary DFMApplicationIntegrationType
    let originalResponseMessageId: Snowflake?
    let interactedMessageId: Snowflake?
    let triggeringInteractionMetadata: DFMMessageInteractionMetadata? // pretty unnecessary
}

class DFMMessageInteraction: Codable {
    let id: Snowflake
    let type: DFMMessageInteractionType
    let name: String
    let user: DFMUser
    let member: DFMGuildMember?
}

enum DFMStickerType: Int, Codable {
    case png = 1
    case apng = 2
    case lottie = 3
    case gif = 4
}

class DFMStickerItem: Codable {
    let id: Snowflake
    let name: String
    let formatType: DFMStickerType
}

class DFMRoleSubscriptionData: Codable {
    let roleSubcriptionListingId: Snowflake
    let tierName: String
    let totalMonthsSubcribed: Int
    let isRenewal: Bool
}

class DFMMessageResolvedData: Codable {
    let users: Dictionary<Snowflake, DFMUser>?
    let members: Dictionary<Snowflake, DFMGuildMember>?
    let roles: Dictionary<Snowflake, DFMRole>?
    let channels: Dictionary<Snowflake, DFMChannel>? // partial channel supposedly
    let messages: Dictionary<Snowflake, DFMMessage>? // partial message supposedly
    let attachments: Dictionary<Snowflake, DFMAttachment>?
}

class DFMPollMediaObject: Codable {
    let text: String?
    let emoji: DFMEmoji? // partial emoji supposedly
}

class DFMPollAnswerObject: Codable {
    let answerId: Int
    let pollMedia: DFMPollMediaObject
}

class DFMPollAnswerCountObject: Codable {
    let id: Int // answerId
    let count: Int
    let meVoted: Bool
}

class DFMPollResultsObject: Codable {
    let isFinalized: Bool
    let answerCounts: [DFMPollAnswerCountObject]
}

class DFMPoll: Codable {
    let question: DFMPollMediaObject
    let answers: [DFMPollAnswerObject]
    let expiry: String // iso8601 timestamp
    let allowMultiselect: Bool
    let layoutType: Int
    let results: DFMPollResultsObject
}

class DFMMessageCall: Codable { // in a private channel
    let participants: [Snowflake]
    let endedTimestamp: String? // iso8601 timestamp
}

class DFMMessage: Codable, Identifiable, CustomStringConvertible {
    var description: String {
        return content ?? "Empty Message"
    }
    
    let id: Snowflake
    let channelId: Snowflake
    let author: DFMUser?
    let content: String?
    let timestamp: String // date
    let editedTimestamp: String? // date
    let tts: Bool
    let mentionEveryone: Bool
    let mentions: [DFMGatewayServerMessageUser]
    let mentionRoles: [String]
    let mentionChannels: [DFMChannel]?
    let attachments: [DFMAttachment]?
    let embeds: [DFMEmbed]?
    let reactions: [DFMReaction]?
    let nonce: String?
    let pinned: Bool
    let webhookId: Snowflake?
    let type: DFMMessageType
    let activity: DFMMessageActivity?
    let application: String?
    let applicationId: Snowflake?
    let messageReference: DFMMessageReference?
    let flags: DFMMessageFlags?
    let referencedMessage: DFMMessage?
    let interactionMetadata: DFMMessageInteractionMetadata?
    let interaction: DFMMessageInteraction?
    let thread: DFMChannel?
    // let components: [MessageComponent]? TODO: this is complicated, look at it later
    let stickerItems: [DFMStickerItem]?
    let stickers: [DFMSticker]?
    let position: Int?
    let roleSubscriptionData: DFMRoleSubscriptionData?
    let resolved: DFMMessageResolvedData?
    let poll: DFMPoll?
    let call: DFMMessageCall?
    
    let guildId: Snowflake?
    let member: DFMGuildMember?
}

class DFMClientMessage: Codable {
    let content: String?
    let nonce: String?
    let tts: Bool?
    let embeds: [DFMEmbed]?
    // let allowedMentions
    let messageReference: DFMMessageReference?
    // let components
    let stickerIds: [Snowflake]?
    // let files
    // let payload_json
    // let attachments
    let flags: DFMMessageFlags?
    let enforceNonce: Bool?
    let poll: DFMPoll?
    
    init(_ content: String, nonce: String, tts: Bool = false) {
        self.content = content
        self.nonce = nonce
        self.tts = tts
        self.embeds = nil
        self.messageReference = nil
        self.stickerIds = nil
        self.flags = nil
        self.enforceNonce = nil
        self.poll = nil
    }
}
