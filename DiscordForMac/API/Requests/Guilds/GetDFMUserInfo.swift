////
////  GetDFMUserInfo.swift
////  DiscordForMac
////
////  Created by Adithiya Venkatakrishnan on 11/5/2024.
////
//
//import Foundation
//
//func getDFMUserInfo() async {
//    if let url = URL(string: "\(DFMConstants.restBaseURL)/users/@me") {
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue(DFMConstants.DFMSecrets.token, forHTTPHeaderField: "Authorization")
//        if let (data, _) = try? await URLSession.shared.data(for: request) {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            if let decodedResponse = try? decoder.decode(DFMUser.self, from: data) {
//                await DFMInformation.shared.setUserInfo(decodedResponse)
//                return
//            } else {
//                print("failed (decoding)")
//                print(String(data: data, encoding: .utf8)!)
//                do {
//                    let decodedResponse = try decoder.decode(DFMUser.self, from: data)
//                } catch {
//                    print(error)
//                }
//                await DFMInformation.shared.setError(DFMError(error: "Unable to process user info.", code: .APIParseFailure))
//                return
//            }
//        } else {
//            print("failed (no internet)")
//            await DFMInformation.shared.setError(DFMError(error: "Unable to connect to server.", code: .InternetFailure))
//            return
//        }
//    } else {
//        print("failed (wrong url)")
//        await DFMInformation.shared.setError(DFMError(error: "Unable to form request.", code: .InternalFailure))
//        return
//    }
//}
