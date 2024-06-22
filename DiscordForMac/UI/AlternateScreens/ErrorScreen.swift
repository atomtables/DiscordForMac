//
//  ErrorScreen.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 13/06/2024.
//

import Foundation
import SwiftUI

struct ErrorScreen: View {
    let error: DFMErrorViewInfo
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .padding(1)
                .scaleEffect(2)
            
            Text("There was an error loading data.")
                .font(.title2)
            
            Text(error.error)
        }
    }
    
}
