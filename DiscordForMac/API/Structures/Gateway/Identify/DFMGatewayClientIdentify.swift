//
//  DFMGatewayClientIdentify.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/05/2024.
//

import Foundation

public struct DFMGatewayClientIdentify: Codable {
    var op: Int = 2
    var d: DFMGatewayClientIdentifyStructure = DFMGatewayClientIdentifyStructure()
}

public struct DFMGatewayClientIdentifyStructure: Codable {
    var token: String = DFMConstants.DFMSecrets.token
    var properties: DFMGatewayClientIdentifyConnectionProperties = DFMGatewayClientIdentifyConnectionProperties()
    var capabilities: Int = 16381
    var presence: DFMGatewayClientPresence = DFMGatewayClientPresence()
    var compress: Bool = false
}

public struct DFMGatewayClientIdentifyConnectionProperties: Codable {
    var os: String = "Mac OS X"
    var browser: String = "Chrome"
    var device: String = ""
    var systemLocale: String = "en-GB"
    var browserUserAgent: String = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
    var browserVersion: String = "124.0.0.0"
    var osVersion: String = "10.15.7"
    var referrer: String = ""
    var referringDomain: String = ""
    var referrerCurrent: String = ""
    var referringDomainCurrent: String = ""
    var releaseChannel: String = ""
    var clientBuildNumber: Int = 292725
    @CodableExplicitNull var clientEventSource: Bool? = nil
    var designID: Int = 0
}

public struct DFMGatewayClientPresence: Codable {
    var since: Int = 0
    var activities: [String] = []
    var status: String = "unknown"
    var afk: Bool = false
}

/*public struct DFMGatewayActivity: Codable {
    var name: String
    var type: DFMGatewayActivityType
    var url: String?
    var createdAt: Int?
    var timestamps:
}

public enum DFMGatewayActivityType: Int, Codable {
    case game = 0
    case stream = 1
    case listen = 2
    case watch = 3
    case custom = 4
    case competing = 5
}
*/
