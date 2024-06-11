//
//  DFMUserFlags.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct DFMUserFlags: Codable, CustomStringConvertible, Hashable {
    let int: Int64
    var uint: UInt64 {
        UInt64(int)
    }
    
    init(_ value: Int64) {
        self.int = value
    }
    
    init(_ value: String) throws {
        self.int = Int64(value)!
    }
    
    var description: String {
        return "\(int)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            int = try container.decode(Int64.self)
        } catch {
            let string = try container.decode(String.self)
            int = Int64(string)!
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(int)
    }
    
    func toSet() -> Set<DFMUserFlagsType> {
        var set = Set<DFMUserFlagsType>()
        
        for flag in DFMUserFlagsType.allCases {
            if (uint & flag.rawValue) == flag.rawValue {
                set.insert(flag)
            }
        }
        
        return set
    }
}

enum DFMUserFlagsType: UInt64, Codable, Hashable, CaseIterable {
    case staff = 1
    case partner = 2
    case hypesquadEventsMember = 4
    case bugHunterLevel1 = 8
    case hypesquadBraveryMember = 64
    case hypesquadBrillianceMember = 128
    case hypesquadBalanceMember = 256
    case nitroEarlySupporter = 512
    case teamPseudoUser = 1024
    case bugHunterLevel2 = 16384
    case verifiedBot = 65536
    case verifiedDeveloper = 131072
    case certifiedModerator = 262144
    case botHttpInteractions = 524288
    case activeDeveloper = 4194304
}
