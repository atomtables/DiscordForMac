//
//  DFMPermission.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMPermission: Codable, CustomStringConvertible, Hashable {
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
    
    func toSet() -> Set<DFMPermissionType> {
        var set = Set<DFMPermissionType>()
        
        for perm in DFMPermissionType.allCases {
            if (uint & perm.rawValue) == perm.rawValue {
                set.insert(perm)
            }
        }
        
        return set
    }
}

enum DFMPermissionType: UInt64, Codable, Hashable, CaseIterable {
    case createInstantInvite = 0x0000000000000001 // Allows creation of instant invites
    case kickMembers = 0x0000000000000002 // Allows kicking members
    case banMembers = 0x0000000000000004 // Allows banning members
    case administrator = 0x0000000000000008 // Allows all permissions and bypasses channel permission overwrites
    case manageChannels = 0x0000000000000010 // Allows management and editing of channels
    case manageGuild = 0x0000000000000020 // Allows management and editing of the guild
    case addReactions = 0x0000000000000040 // Allows for the addition of reactions to messages
    case viewAuditLog = 0x0000000000000080 // Allows for viewing of audit logs
    case prioritySpeaker = 0x0000000000000100 // Allows for using priority speaker in a voice channel
    case stream = 0x0000000000000200 // Allows the user to go live
    case viewChannel = 0x0000000000000400 // Allows guild members to view a channel
    case sendMessages = 0x0000000000000800 // Allows for sending messages in a channel and creating threads in a forum
    case sendTtsMessages = 0x0000000000001000 // Allows for sending of /tts messages
    case manageMessages = 0x0000000000002000 // Allows for deletion of other users messages
    case embedLinks = 0x0000000000004000 // Links sent by users with this permission will be auto-embedded
    case attachFiles = 0x0000000000008000 // Allows for uploading images and files
    case readMessageHistory = 0x0000000000010000 // Allows for reading of message history
    case mentionEveryone = 0x0000000000020000 // Allows for using the @everyone tag to notify all users in a channel
    case useExternalEmojis = 0x0000000000040000 // Allows the usage of custom emojis from other servers
    case viewGuildInsights = 0x0000000000080000 // Allows for viewing guild insights
    case connect = 0x0000000000100000 // Allows for joining of a voice channel
    case speak = 0x0000000000200000 // Allows for speaking in a voice channel
    case muteMembers = 0x0000000000400000 // Allows for muting members in a voice channel
    case deafenMembers = 0x0000000000800000 // Allows for deafening of members in a voice channel
    case moveMembers = 0x0000000001000000 // Allows for moving of members between voice channels
    case useVad = 0x0000000002000000 // Allows for using voice-activity-detection in a voice channel
    case changeNickname = 0x0000000004000000 // Allows for modification of own nickname
    case manageNicknames = 0x0000000008000000 // Allows for modification of other users nicknames
    case manageRoles = 0x0000000010000000 // Allows management and editing of roles
    case manageWebhooks = 0x0000000020000000 // Allows management and editing of webhooks
    case manageGuildExpressions = 0x0000000040000000 // Allows for editing and deleting emojis, stickers, and soundboard sounds created by all users
    case useApplicationCommands = 0x0000000080000000 // Allows members to use application commands
    case requestToSpeak = 0x0000000100000000 // Allows for requesting to speak in stage channels
    case manageEvents = 0x0000000200000000 // Allows for editing and deleting scheduled events created by all users
    case manageThreads = 0x0000000400000000 // Allows for deleting and archiving threads, and viewing all private threads
    case createPublicThreads = 0x0000000800000000 // Allows for creating public and announcement threads
    case createPrivateThreads = 0x0000001000000000 // Allows for creating private threads
    case useExternalStickers = 0x0000002000000000 // Allows the usage of custom stickers from other servers
    case sendMessagesInThreads = 0x0000004000000000 // Allows for sending messages in threads
    case useEmbeddedActivities = 0x0000008000000000 // Allows for using Activities (applications with the EMBEDDED flag) in a voice channel
    case moderateMembers = 0x0000010000000000 // Allows for timing out users to prevent them from sending or reacting to messages in chat and threads, and from speaking in voice and stage channels
    case viewCreatorMonetizationAnalytics = 0x0000020000000000 // Allows for viewing role subscription insights
    case useSoundboard = 0x0000040000000000 // Allows for using soundboard in a voice channel
    case createGuildExpressions = 0x0000080000000000 // Allows for creating emojis, stickers, and soundboard sounds, and editing and deleting those created by the current user
    case createEvents = 0x0000100000000000 // Allows for creating scheduled events, and editing and deleting those created by the current user
    case useExternalSounds = 0x0000200000000000 // Allows the usage of custom soundboard sounds from other servers
    case sendVoiceMessages = 0x0000400000000000 // Allows sending voice messages
    case sendPolls = 0x0002000000000000 // Allows sending polls
}

