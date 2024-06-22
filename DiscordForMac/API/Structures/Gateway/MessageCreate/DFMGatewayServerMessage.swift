//
//  DFMGatewayServerMessage.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 05/06/2024.
//

import Foundation

class DFMGatewayServerMessage: Codable {
    let d: DFMMessage
}

class DFMGatewayServerMessageUser: Codable {
    var id: Snowflake
    var username: String
    var discriminator: String
    var globalName: String?
    var avatar: String?
    var avatarURL: URL {
        if let avatar {
            return URL(string: "\(DFMConstants.iconBaseURL)/avatars/\(id)/\(avatar).png")!
        } else if Int(discriminator) != 0 && Int(discriminator) != nil {
            return URL(string: "\(DFMConstants.iconBaseURL)/embed/avatars/\(Int(discriminator)!%5).png")!
        } else {
            return URL(string: "\(DFMConstants.iconBaseURL)/embed/avatars/\((id.int >> 22) % 6).png")!
        }
    }
    var bot: Bool?
    var system: Bool?
    var mfaEnabled: Bool?
    var banner: Bool?
    var accentColor: Int?
    var locale: String?
    var verified: Bool?
    var email: String?
    var flags: DFMUserFlags?
    var premiumType: Int?
    var publicFlags: DFMUserFlags?
    var avatarDecoration: String?
    let member: DFMGuildMember?
}

class DFMGatewayServerMessageStructure: Codable {
    let id: Snowflake
    let channelId: Snowflake
    let author: DFMUser?
    let content: String?
    let timestamp: Date // date
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
    
    init(id: Snowflake, channelId: Snowflake, author: DFMUser?, content: String?, timestamp: Date, editedTimestamp: String?, tts: Bool, mentionEveryone: Bool, mentions: [DFMGatewayServerMessageUser], mentionRoles: [String], mentionChannels: [DFMChannel]?, attachments: [DFMAttachment]?, embeds: [DFMEmbed]?, reactions: [DFMReaction]?, nonce: String?, pinned: Bool, webhookId: Snowflake?, type: DFMMessageType, activity: DFMMessageActivity?, application: String?, applicationId: Snowflake?, messageReference: DFMMessageReference?, flags: DFMMessageFlags?, referencedMessage: DFMMessage?, interactionMetadata: DFMMessageInteractionMetadata?, interaction: DFMMessageInteraction?, thread: DFMChannel?, stickerItems: [DFMStickerItem]?, stickers: [DFMSticker]?, position: Int?, roleSubscriptionData: DFMRoleSubscriptionData?, resolved: DFMMessageResolvedData?, poll: DFMPoll?, call: DFMMessageCall?, guildId: Snowflake?, member: DFMGuildMember?) {
        self.id = id
        self.channelId = channelId
        self.author = author
        self.content = content
        self.timestamp = timestamp
        self.editedTimestamp = editedTimestamp
        self.tts = tts
        self.mentionEveryone = mentionEveryone
        self.mentions = mentions
        self.mentionRoles = mentionRoles
        self.mentionChannels = mentionChannels
        self.attachments = attachments
        self.embeds = embeds
        self.reactions = reactions
        self.nonce = nonce
        self.pinned = pinned
        self.webhookId = webhookId
        self.type = type
        self.activity = activity
        self.application = application
        self.applicationId = applicationId
        self.messageReference = messageReference
        self.flags = flags
        self.referencedMessage = referencedMessage
        self.interactionMetadata = interactionMetadata
        self.interaction = interaction
        self.thread = thread
        self.stickerItems = stickerItems
        self.stickers = stickers
        self.position = position
        self.roleSubscriptionData = roleSubscriptionData
        self.resolved = resolved
        self.poll = poll
        self.call = call
        self.guildId = guildId
        self.member = member
    }
}
