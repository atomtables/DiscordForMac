//
//  DFMGuildMember.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMGuildMember: Codable, Hashable {
    var user: DFMUser?
    let nick: String?
    let avatar: String?
    let roles: [String]
    let joinedAt: String // ISO8601 timestamp
    let premiumSince: String? // ISO8601 timestamp
    let deaf: Bool
    let mute: Bool
    let flags: Int
    let pending: Bool?
    let permissions: String?
    let communicationDisabledUntil: String? // ISO8601 timestamp
}
