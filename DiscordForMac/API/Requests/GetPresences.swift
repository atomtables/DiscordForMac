//
//  GetPresences.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 02/06/2024.
//

import Foundation

/// to be ran upon receive of ready from `DFMGatewayConnectionSocket`
/// actually this is deprecated, you use `READY_SUPPLEMENTAL` for information
//func GetPresences() async {
//    if let url = URL(string: "\(DFMConstants.restBaseURL)/presences") {
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue(DFMConstants.DFMSecrets.token, forHTTPHeaderField: "Authorization")
//        let data: Data;
//        do {
//            data = try await URLSession.shared.data(for: request).0
//        } catch {
//            print("Network Error: \(error)")
//            return
//        }
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let decodedResponse: [DFMPresence]
//        do {
//            decodedResponse = try decoder.decode(DFMPresenceResponse.self, from: data).presences
//        } catch {
//            print("Decoding Error: \(error)")
//            return
//        }
//        await DFMInformation.shared.setPresences(decodedResponse)
//    } else {
//        fatalError("unable to form the correct url, app's probably corrupted")
//    }
//}
