//
//  DFMSticker.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMSticker: Codable, Identifiable, Hashable {
    let id: Snowflake
    let packId: Snowflake?
    let name: String
    let description: String?
    let tags: String
    let asset: String?
    let type: DFMDCStickerType
    let formatType: DFMStickerFormatType
    let available: Bool
    let guildId: Snowflake?
    let user: DFMUser?
    let sortValue: Int?
}

enum DFMDCStickerType: Int, Codable, Hashable {
    case standard = 1
    case guild = 2
}

enum DFMStickerFormatType: Int, Codable, Hashable {
    case png = 1
    case apng = 2
    case lottie = 3
    case gif = 4
}
