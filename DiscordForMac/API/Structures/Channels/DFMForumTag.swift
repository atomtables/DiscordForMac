//
//  DFMForumTag.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMForumTag: Codable, Identifiable, Hashable {
    var id: Snowflake
    var name: String
    var moderated: Bool
    var emojiId: Snowflake?
    var emojiName: String?
}
