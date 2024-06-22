//
//  DFMUsers.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 10/5/2024.
//

import Foundation

/// A structure to store user information
/// Email can only be accessed on `/users/@me`
struct DFMUser: Codable, Identifiable, Hashable {
    var id: Snowflake
    var username: String
    var discriminator: String
    var globalName: String?
    var avatar: String?
    var avatarURL: URL {
        if let avatar {
            return URL(string: "\(DFMConstants.iconBaseURL)/avatars/\(id)/\(avatar).png")!
        } else if let disc = Int(discriminator), disc != 0 {
            return URL(string: "\(DFMConstants.iconBaseURL)/embed/avatars/\(disc%5).png")!
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
}
