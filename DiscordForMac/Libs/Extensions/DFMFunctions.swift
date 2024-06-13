//
//  DFMFunctions.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 12/06/2024.
//

import Foundation

func areSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
    let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
    
    return components1.year == components2.year &&
           components1.month == components2.month &&
           components1.day == components2.day
}

