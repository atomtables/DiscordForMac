//
//  DFMImageView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 10/5/2024.
//

import SwiftUI

///#DFMImage
/// Placeholder that processes images into an image cache.
/// - Parameter url: url which should be loaded
/// - Returns a view that loads an image, showing `ProgessView` while loading it.
struct DFMImageView: View {
    let url: URL
    #if os(macOS)
    @State private var image: NSImage?
    #elseif os(iOS)
    @State private var image: UIImage?
    #endif

    var body: some View {
        if let image = image {
            #if os(macOS)
            Image(nsImage: image)
                .resizable()
            #elseif os(iOS)
            Image(uiImage: image)
                .resizable()
            #endif
        } else {
            ProgressView()
                .onAppear {
                    DFMImageCache.shared.loadImage(url: url) { loadedImage in
                        self.image = loadedImage
                    }
                }
        }
    }
}

