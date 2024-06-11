//
//  DFMThreadMember.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMThreadMember: Codable, Identifiable, Hashable {
    var id: Snowflake?
    var userId: Snowflake?
    var joinTimestamp: String
    var flags: Int
    var member: DFMGuildMember?
}
