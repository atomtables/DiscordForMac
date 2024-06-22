//
//  GetMessages.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 01/06/2024.
//

import Foundation

/// Gets historic messages for a chat
/// Live messages will be received through the gateway
/// by `DFMMessageUpdater`
func GetMessages(_ channel: Snowflake,
                 limit: Int = 50,
                 around: Snowflake? = nil,
                 before: Snowflake? = nil,
                 after: Snowflake? = nil
) async throws -> [DFMMessage] {
    var urlString = "\(DFMConstants.restBaseURL)/channels/\(channel)/messages"
    urlString += "?limit=\(limit)"
    if let around {
        urlString += "&around=\(around)"
    } else if let before {
        urlString += "&before=\(before)"
    } else if let after {
        urlString += "&after=\(after)"
    }
    if let url = URL(string: urlString) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(DFMConstants.DFMSecrets.token, forHTTPHeaderField: "Authorization")
        let data: Data;
        do {
            data = try await URLSession.shared.data(for: request).0
        } catch {
            PrintDebug("Network Error: \(error)")
            throw DFMError.thrownError("Network Error: \(error)")
        }
        let decoder = DFMConstants.decoder
        let decodedResponse: [DFMMessage]
        do {
            decodedResponse = try decoder.decode([DFMMessage].self, from: data)
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
