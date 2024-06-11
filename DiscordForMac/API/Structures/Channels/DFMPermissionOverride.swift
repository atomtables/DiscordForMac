//
//  DFMPermissionOverride.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMPermissionOverwrite: Codable, Identifiable, Hashable {
    var id: String
    var type: DFMPermissionOverwriteType
    var allow: DFMPermission
    var deny: DFMPermission
}

enum DFMPermissionOverwriteType: Int, Codable, Hashable {
    case role = 0
    case member = 1
}
