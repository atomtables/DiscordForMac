//
//  DFMImageCache.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 10/5/2024.
//

import Foundation
import SwiftUI
#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

class DFMImageCache {
    static let shared = DFMImageCache()
    #if os(macOS)
    private var cache = NSCache<NSURL, NSImage>()
    #elseif os(iOS)
    private var cache = NSCache<NSURL, UIImage>()
    #endif

    #if os(macOS)
    func loadImage(url: URL, completion: @escaping (NSImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = NSImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    #elseif os(iOS)
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    #endif
}
