////
////  GetDFMGuildsPartial.swift
////  DiscordForMac
////
////  Created by Adithiya Venkatakrishnan on 10/5/2024.
////
//
//import Foundation
//
//func getDFMGuildsList() async {
//    if let url = URL(string: "\(DFMConstants.restBaseURL)/users/@me/guilds?with_counts=true") {
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue(DFMConstants.DFMSecrets.token, forHTTPHeaderField: "Authorization")
//        if let (data, _) = try? await URLSession.shared.data(for: request) {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            if var decodedResponse = try? decoder.decode([DFMGuild].self, from: data) {
//                let dms = DFMGuild(id: Snowflake(0), name: "Direct Messages", dms: true)
//                decodedResponse.insert(dms, at: 0)
//                await DFMInformation.shared.setGuildList(decodedResponse)
//                return
//            } else {
//                print("failed (decoding)")
//                print(String(data: data, encoding: .utf8)!)
//                do {
//                    let decodedResponse = try decoder.decode([DFMGuild].self, from: data)
//                } catch {
//                    print(error)
//                }
//                await DFMInformation.shared.setError(DFMError(error: "Unable to process guilds.", code: .APIParseFailure))
//                return
//            }
//        } else {
//            print("failed (no internet)")
//            await DFMInformation.shared.setError(DFMError(error: "Unable to connect to the internet.", code: .InternetFailure))
//            return
//        }
//    } else {
//        print("failed (wrong url)")
//        await DFMInformation.shared.setError(DFMError(error: "Unable to form request.", code: .InternalFailure))
//        return
//    }
//}
