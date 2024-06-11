//
//  DFMRole.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMRole: Codable, Identifiable, Hashable {
    var id: Snowflake
    var name: String
    var color: Int
    var hoist: Bool
    var icon: String?
    var unicodeEmoji: String?
    var position: Int
    var permissions: DFMPermission
    var managed: Bool
    var mentionable: Bool
    // missing role tags
    var flags: Int // unnecessary
}
