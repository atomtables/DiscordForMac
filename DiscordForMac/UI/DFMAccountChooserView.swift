//
//  DFMAccountChooserView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 20/06/2024.
//

import Foundation
import SwiftUI

struct DFMAccountChooserView: View {
    @EnvironmentObject var info: DFMInformation

    @State var userDefaultsUserInformation: [String: Data] = [:]

    var userInformation: [String: DFMUser] {
        var dict: [String: DFMUser] = [:]
        for (key, value) in userDefaultsUserInformation {
            do {
                dict[key] = try DFMConstants.decoder.decode(DFMUser.self, from: value)
                PrintDebug(dict[key] ?? "")
            } catch {}
        }
        return dict
    }

    var body: some View {
        VStack {
            Text("Choose an account to log into.")
            VStack {
                ForEach(
                    Array(info.keychainItems.enumerated()),
                    id: \.offset
                ) { (i, key) in
                    if i != 0 {
                        Divider()
                            .frame(width: 450)
                    }
                    HStack {
                        HStack {
                            if let user = userInformation[key[0]] {
                                DFMImageView(
                                    url: user.avatarURL
                                )
                                .frame(width: 40, height: 40, alignment: .center)
                                .cornerRadius(10)
                                VStack(alignment: .leading) {
                                    Text(
                                        user.globalName ?? user.username
                                    )
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    Text(key[0])
                                }
                            }
                        }
                        Spacer()
                        if key[1] != "" {
                            Image(systemName: "touchid")
                        }
                        Button {
                            Task {
                                DFMConstants.DFMSecrets.email = key[0]
                                NotificationCenter.default
                                    .post(name: Notification.Name("DFMLogOutUpdate"), object: nil)
                            }
                        } label: {
                            Text("Log out")
                        }
                        Button {
                            Task {
                                getAccountToken(from: key[0])
                                info.shouldChangeAccount = false
                            }
                        } label: {
                            Text("Sign in")
                        }
                    }
                    .frame(width: 400)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(BackgroundStyle.background)
            .cornerRadius(10)
            HStack {
                Button {
                    info.shouldAddNewAccount = (true, nil)
                    info.shouldShowAccountChooser = true
                } label: {
                    Text("Add a new account")
                }
            }
        }
        .toolbar {
            if info.shouldChangeAccount {
                Button {
                    info.shouldShowAccountChooser = false
                    info.shouldChangeAccount = false
                } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                    Text("Back")
                }
            }
        }
        .task {
            userDefaultsUserInformation = UserDefaults.standard
                .object(forKey: "DFMUserInformation") as? [String: Data] ?? [String: Data]()
        }
    }
}
