//
//  AppIcon.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 07/06/2024.
//

import Foundation
import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

#if os(macOS)
struct AppIcon: View {
    var body: Image {
        Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
    }
}
#elseif os(iOS)
struct AppIcon: View {
    var body: Image {
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
    }
}
#endif
