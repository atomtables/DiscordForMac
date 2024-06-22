//
//  DividerWithLabel.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/06/2024.
//

import Foundation
import SwiftUI

struct DividerWithLabel: View {
    let label: String
    let padding: CGFloat
    let color: Color
    
    init(label: String, padding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.padding = padding
        self.color = color
    }
    
    var body: some View {
        HStack {
            dividerLine
            Text(label).foregroundColor(color)
            dividerLine
        }
    }
    
    private var dividerLine: some View {
        return VStack { Divider().background(color) }.padding(padding)
    }
}
