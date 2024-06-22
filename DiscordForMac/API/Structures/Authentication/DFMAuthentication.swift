//
//  Authentication.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 14/06/2024.
//

import AnyCodable

struct DFMLoginCheckForCaptcha: Codable {
    let captchaKey: AnyCodable
}

struct DFMEmailAndPasswordAuthentication: Codable {
    var login: String
    var password: String
    var undelete: Bool = false
}

struct DFMAuthenticationResponse: Codable {
    var userId: Snowflake?
    var mfa: Bool?
    var sms: Bool?
    var ticket: String?
    var backup: Bool?
    var totp: Bool?
    // var webauthn: Something (yet to find this)
    var token: String?
    var userSettings: DFMEmailAndPasswordAuthenticationResponseUserSettings?
}

struct DFMEmailAndPasswordAuthenticationResponseUserSettings: Codable {
    var locale: String?
    var theme: String?
}

struct DFMTOTPTwoStepLogin: Codable {
    var code: String
    var ticket: String
}

struct DFMTOTPTwoStepLoginResponse: Codable {
    var token: String
    var userSettings: DFMEmailAndPasswordAuthenticationResponseUserSettings?
}

struct DFMMOTPTwoStepSendRequest: Codable {
    var ticket: String
}

struct DFMMOTPTwoStepSendResponse: Codable {
    var phone: String
}

struct DFMTOTPTwoStepSendRequest: Codable {
    let code: String
    let ticket: String
}
