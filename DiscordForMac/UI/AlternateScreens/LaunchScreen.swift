//
//  LaunchScreen.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/06/2024.
//

import SwiftUI

struct LaunchScreen<Content>: View where Content: View {
    var content: () -> Content

    @State private var animate: Bool = false

    @State private var contentAnimate: Bool = false

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public func hideAway() {
        animate = false
    }
    
    var body: some View {
        if !(!DFMInformation.shared.loadingScreen.0 && DFMInformation.shared.error == nil && !DFMInformation.shared.shouldShowAccountChooser) {
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
                .transition(.slide)
                .animation(.easeOut(duration: 1.0), value: animate)
                .animation(.spring(duration: 1.0))
                .padding(5)
                .transition(.slide)
                content()
                    .offset(y: contentAnimate ? 0 : 25)
                    .opacity(contentAnimate ? 1 : 0)
                    .animation(.easeOut(duration: 1.0), value: contentAnimate)
                    .animation(.spring(duration: 1.0), value: UUID())
                Spacer()
            }
            .onAppear {
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    contentAnimate = true
                }
            }
            .onDisappear {
                animate = false
                contentAnimate = false
            }
        } else {
            content()
        }
    }
}

