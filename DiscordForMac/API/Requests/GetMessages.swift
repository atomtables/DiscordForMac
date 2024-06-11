//
//  GetMessages.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 01/06/2024.
//

import Foundation

func GetMessages(_ channel: Snowflake, 
                 limit: Int = 50,
                 around: Snowflake? = nil,
                 before: Snowflake? = nil,
                 after: Snowflake? = nil
) async throws -> [DFMMessage] {
    if let url = URL(string: "\(DFMConstants.restBaseURL)/channels/\(channel)/messages") {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(DFMConstants.DFMSecrets.token, forHTTPHeaderField: "Authorization")
        let data: Data;
        do {
            data = try await URLSession.shared.data(for: request).0
        } catch {
            print("Network Error: \(error)")
            throw DFMError.thrownError("Network Error: \(error)")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse: [DFMMessage] 
        do {
            decodedResponse = try decoder.decode([DFMMessage].self, from: data)
        } catch {
            print("Decoding Error: \(error)")
            print("Data: \(String(data: data, encoding: .utf8)!)")
            throw DFMError.thrownError("Decoding Error: \(error)")
        }
        return decodedResponse
    } else {
        fatalError("Malformed request.")
    }
}
