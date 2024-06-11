//
//  SendMessage.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 04/06/2024.
//

import Foundation

func SendMessage(_ channel: Snowflake, textMessage: String) async throws -> String {
    let nonce = String(Int64(arc4random()))
    let message = DFMClientMessage(textMessage, nonce: nonce)
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    var data: Data
    do {
        data = try encoder.encode(message)
    } catch {
         throw DFMError.thrownError("Encoding error: \(error)")
    }
    var request = URLRequest(url: URL(string: "https://discord.com/api/v9/channels/\(channel)/messages")!)
    request.httpMethod = "POST"
    request.setValue(DFMConstants.DFMSecrets.token, forHTTPHeaderField: "Authorization")
    request.httpBody = data
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    do {
        data = try await URLSession.shared.data(for: request).0
    } catch {
        throw DFMError.thrownError("Network error: \(error)")
    }
    print(String(data: data, encoding: .utf8)!)
    return nonce
}
