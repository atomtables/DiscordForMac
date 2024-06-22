//
//  LaunchScreen.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/06/2024.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var animate = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                AppIcon()
                    .frame(width: 64, height: 64)
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text("DiscordForMac")
                        .bold()
                        .font(.title2)
                    Text("by atomtables")
                        .fontWeight(.light)
                        .font(.headline)
                }
                    .offset(x: -5)
            }
            .offset(y: animate ? 0 : 100)
            .opacity(animate ? 1 : 0)
            .animation(.easeOut(duration: 1.0), value: animate)
            .onAppear {
                animate = true
            }
            .padding(5)
            Spacer()
        }
    }
}

#Preview {
    LaunchScreen()
}
