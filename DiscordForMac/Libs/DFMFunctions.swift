//
//  DFMFunctions.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 12/06/2024.
//

import Foundation
import UserNotifications

func areSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
    let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
    
    return components1.year == components2.year &&
           components1.month == components2.month &&
           components1.day == components2.day
}

func grantPermissionForNotifications() {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            print("Yay!")
        } else {
            print(error ?? "the error doesn't even exist anymore :pensive:")
        }
    }
}

func showNotification(title: String, subtitle: String, body: String) -> Void {
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.body = body
    content.sound = .init(named: .init("DFMNotificationSound.mp3"))
        
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)

    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error adding notification: \(error.localizedDescription)")
        }
    }
}
