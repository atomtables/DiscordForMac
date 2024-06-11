//
//  DateFormatter.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 15/05/2024.
//

import Foundation

extension DateFormatter {
    // 2023-11-13T23:00:20.803000+00:00
    // 2024-04-30T01:19:49.919000+00:00
    // 2023-11-27T23:07:25.796000+00:00
    // 2022-04-30T16:36:52.555000+00:00
    
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return formatter
    }()
    
    static func customFormattedDate(from timestamp: String) -> String? {
        let inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        let outputFormat = "MMM dd, yyyy hh:mm:ss a"
        
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        // Convert the timestamp string to a Date object
        if let date = dateFormatter.date(from: timestamp) {
            // Create another DateFormatter instance for the desired output format
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = outputFormat
            
            // Format the date
            return outputDateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
