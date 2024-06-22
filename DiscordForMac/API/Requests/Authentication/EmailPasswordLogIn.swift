//
//  EmailPasswordLogIn.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 14/06/2024.
//

import Foundation
import AnyCodable

/// returns the "email and password auth response" object, so that whatever called it has the honour of dealing with it.
func LogInWithEmailAndPassword(with email: String, password: String) async throws -> DFMAuthenticationResponse {
    if let url = URL(string: "\(DFMConstants.restBaseURL)/auth/login") {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let requestBody = try! DFMConstants.encoder.encode(DFMEmailAndPasswordAuthentication(login: email, password: password))
        request.httpBody = requestBody
        let data: Data;
        do {
            data = try await URLSession.shared.data(for: request).0
        } catch {
            PrintDebug("Network Error: \(error)")
            throw DFMError.thrownError("Network Error: \(error)")
        }
        let decoder = DFMConstants.decoder
        do {
            return try decoder.decode(DFMAuthenticationResponse.self, from: data)
        } catch {
            PrintDebug("Decoding Error: \(error)")
            PrintDebug("Data: \(String(data: data, encoding: .utf8)!)")
            // TODO: during a decoding error it could be the server just has an error. add more specificity to errors.
            var error: DFMRestError = DFMRestError(code: .generalError, message: "")
            do {
                error = try decoder.decode(DFMRestError.self, from: data)
            } catch {
                var captcha = false
                do {
                    let _ = try decoder.decode(DFMLoginCheckForCaptcha.self, from: data)
                    captcha = true
                } catch {
                    throw DFMError.thrownError("Decoding Error: \(error)")
                }
                if captcha {
                    throw DFMError.shownError(.warning, "Discord requires a recaptcha. To bypass this, you should go to \"https://discord.com/login\", enter random credentials, and solve the captcha. Come back here afterwards.")
                }
            }
            if error.code == .invalidFormBody {
                if error.errors?.fieldErrors["login"]?._errors[0].code == "INVALID_LOGIN" || error.errors?.fieldErrors["password"]?._errors[0].code == "INVALID_LOGIN" {
                    throw DFMError.shownError(.warning, "Username or Password is incorrect.")
                }
            }
            throw DFMError.shownError(.critical, "Unknown error. Try again later.")
        }
    } else {
        fatalError("Malformed request.")
    }
}
