//
//  DFMThreadMetadata.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMThreadMetadata: Codable, Hashable {
    let archived: Bool
    let autoArchiveDuration: Int
    let archiveTimestamp: String
    let locked: Bool
    let invitable: Bool?
    let createTimestamp: String?
}
