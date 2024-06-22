//
//  JSONEncoder+JSONDecoder.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/06/2024.
//

import Foundation

extension JSONEncoder {
    convenience init(DFM: Bool = true) {
        self.init()
        self.keyEncodingStrategy = .convertToSnakeCase
        self.dateEncodingStrategy = .customISO8601
    }
}

extension JSONDecoder {
    convenience init(DFM: Bool = true) {
        self.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
        self.dateDecodingStrategy = .customISO8601
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601: JSONDecoder.DateDecodingStrategy = {
        return .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            if let date = DateFormatter.customISO8601WithMillis.date(from: dateString) {
                return date
            } else if let date = DateFormatter.customISO8601WithoutMillis.date(from: dateString) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
            }
        }
    }()
}

extension JSONEncoder.DateEncodingStrategy {
    static let customISO8601: JSONEncoder.DateEncodingStrategy = {
        return .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let dateString = DateFormatter.customISO8601WithoutMillis.string(from: date)
            try container.encode(dateString)
        }
    }()
}
