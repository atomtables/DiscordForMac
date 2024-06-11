//
//  DFMChannelType.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

enum DFMChannelType: Int, Codable, Hashable {
    case serverTextChannel = 0
    case directMessageChannel = 1
    case serverVoiceChannel = 2
    case groupDirectMessageChannel = 3
    case serverChannelCategory = 4
    case serverAnnouncementChannel = 5
    case serverAnnouncementThread = 10
    case serverPublicThread = 11
    case serverPrivateThread = 12
    case serverStageChannel = 13
    case serverDirectory = 14 // i have no idea what this is
    case serverForum = 15
    case serverMedia = 16 // still in active development
}
