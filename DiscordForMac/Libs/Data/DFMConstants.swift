//
//  URLs.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 9/5/2024.
//

import Foundation
import KeychainAccess

public class DFMConstants {
    
    public final class DFMSecrets {
        public static var email = ""
        public static var token = ""
    }

    public static let iconBaseURL = "https://cdn.discordapp.com"
    
    public static let restBaseURL = "https://discord.com/api/v9"
    
    public static let DEBUG = true

    public static let decoder: JSONDecoder = JSONDecoder(DFM: true)
    public static let encoder: JSONEncoder = JSONEncoder(DFM: true)
    
}
