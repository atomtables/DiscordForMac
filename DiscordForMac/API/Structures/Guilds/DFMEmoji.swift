//
//  DFMEmoji.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMEmoji: Codable, Identifiable, Hashable {
    let id: String?
    let name: String?
    let roles: [String]?
    let user: DFMUser?
    let requireColons: Bool?
    let managed: Bool?
    let animated: Bool?
    let available: Bool?
}
