//
//  NSRegularExpression.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 10/5/2024.
//

import Foundation

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matchesGroup(_ string: String) -> String {
        let nsString = string as NSString
        
        let range = NSRange(location: 0, length: string.utf16.count)
        let matches = matches(in: string, options: [], range: range)
        var matchString = ""
        
        for match in matches {
            let matchS = nsString.substring(with: match.range) as String
            matchString += matchS.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        
        return matchString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
