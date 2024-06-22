//
//  GetUser.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 19/06/2024.
//

import Foundation

func GetUser(from token: String) async throws -> DFMUser {
    if let url = URL(string: "\(DFMConstants.restBaseURL)/users/@me") {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        let data: Data;
        do {
            data = try await URLSession.shared.data(for: request).0
        } catch {
            PrintDebug("Network Error: \(error)")
            throw DFMError.thrownError("Network Error: \(error)")
        }
        let decoder = DFMConstants.decoder
        let decodedResponse: DFMUser
        do {
            decodedResponse = try decoder.decode(DFMUser.self, from: data)
        } catch {
            PrintDebug("Decoding Error: \(error)")
            PrintDebug("Data: \(String(data: data, encoding: .utf8)!)")
            throw DFMError.thrownError("Decoding Error: \(error)")
        }
        return decodedResponse
    } else {
        fatalError("Malformed request.")
    }
}
