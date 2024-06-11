//
//  DFMPresence.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 02/06/2024.
//

import Foundation

class DFMPresenceResponse: Codable {
    // var guilds: any Codable this is unrelated
    var presences: [DFMPresence]
}

enum DFMPresenceStatus: String, Codable {
    case online = "online"
    case dnd = "dnd"
    case idle = "idle"
    case offline = "offline"
    
    func format() -> String {
        if self == .online {
            return "Online"
        } else if self == .idle {
            return "Idle"
        } else if self == .dnd {
            return "Do Not Disturb"
        } else if self == .offline {
            return "Offline"
        } else {
            return "Offline"
        }
    }
}

struct DFMPresenceClientStatus: Codable {
    let desktop: DFMPresenceStatus?
    let mobile: DFMPresenceStatus?
    let web: DFMPresenceStatus?
    
    func primaryClient() -> String {
        // desktop > web > mobile
        if desktop != nil {
            return "Desktop"
        } else if web != nil {
            return "Web"
        } else if mobile != nil {
            return "Mobile"
        } else {
            return "offline"
        }
    }
}

struct DFMActivity: Codable {
    let name: String
    let type: DFMGatewayActivityType
    let url: String?
    let createdAt: Int64 // timestamp
    // let timestamps: Unnecessary
    let applicationId: Snowflake?
    let details: String?
    let state: String?
    let emoji: DFMEmoji?
    // let party: DFMParty?
    // let assets: DFMAssets?
    // let secrets: DFMSecrets?
    let instance: Bool?
    let flags: Int?
    // let buttons: some Array
}

struct DFMPresence: Codable {
    let user: DFMUser
    let status: DFMPresenceStatus
    let clientStatus: DFMPresenceClientStatus
    let activities: [DFMActivity]
    
    func getStatus() -> String {
        if activities.count == 0 {
            if status != .offline {
                return "\(status.format()) on \(clientStatus.primaryClient())"
            } else {
                return "Offline"
            }
        } else {
            let activity = activities[0]
            switch activity.type {
            case .game:
                return "Playing \(activity.name)"
            case .stream:
                return "Streaming \(activity.details ?? "nothing...")"
            case .listen:
                return "Listening to \(activity.name)"
            case .watch:
                return "Watching \(activity.name)"
            case .custom:
                if let emoji = activity.emoji {
                    return "\(emoji.name ?? "") \(activity.state ?? "")"
                } else {
                    return activity.state ?? ""
                }
            case .competing:
                return "Competing in \(activity.name)"
            default:
                return "Unknown Process"
            }
        }
    }
}

enum DFMGatewayActivityType: Int, Codable, CaseIterableDefaultsLast {
    case game = 0
    case stream = 1
    case listen = 2
    case watch = 3
    case custom = 4
    case competing = 5
    case unknown = -1
    // theres a type 6 hang status but unnecessary until voice call support
}
