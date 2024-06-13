//
//  VisualEffectView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 12/06/2024.
//

#if os(macOS)
import Foundation
import SwiftUI

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()

        view.blendingMode = .behindWindow
        view.state = .active
        view.material = .underWindowBackground

        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        //
    }
}
#endif
