//
//  Snowflake.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import Foundation

struct Snowflake: Codable, CustomStringConvertible, Hashable {
    
    static func == (lhs: Snowflake, rhs: Int) -> Bool { lhs.int == rhs }
    
    static func != (lhs: Snowflake, rhs: Int) -> Bool { lhs.int != rhs }
    
    var int: Int64
    var uint: UInt64 {
        UInt64(int)
    }
    
    init(_ value: Int) {
        self.int = Int64(value)
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
    
    func toDate() -> Date {
        // Unix timestamp starts from January 1, 1970
        let epoch = TimeInterval(1420070400000)
        
        // Extract timestamp from snowflake (41 bits)
        let timestamp = (self.uint >> 22) + UInt64(epoch)
        
        // Convert timestamp to milliseconds
        let milliseconds = timestamp / 1000
        
        // Create a Date object
        return Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
}
