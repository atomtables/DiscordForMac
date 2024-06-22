//
//  DiscordForMacApp.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 9/5/2024.
//

import SwiftUI

struct Div<Content>: View where Content: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
    }
}

func PrintDebug(_ message: Any) {
    if DFMConstants.DEBUG {
        print(message)
    }
}

@main
struct DiscordForMacApp: App {
    @StateObject var info: DFMInformation = DFMInformation.shared

    @Environment(\.controlActiveState) var controlActiveState

    @State var keys: [String] = []

    @State var _true = true

    @State var help = false
    @State var tokenLoaded = false
    @State var showLoading = false
    @State var showAccountChooser = false

    @State var ranOnce = false

    @State var launchScreenAnimate = false

    @State var account: String = ""

    init() {
        Task {
            DFMUserUpdater()
            DFMGuildsUpdater()
            await DFMUserReferenceUpdater()
            await DFMPrivateChannelsUpdater()
            DFMPresencesUpdater()
            DFMMessageUpdater()
            DFMLogOutUpdater()
        }
    }

    var body: some Scene {
        WindowGroup {
            Div {
                LaunchScreen {
                    if let error = info.error {
                        Text(error.error)
                    } else if info.shouldShowAccountChooser {
                        if info.keychainItems.count > 1 {
                            if info.shouldAddNewAccount.0 {
                                LoginScreen(keys: $keys, animate: $launchScreenAnimate, addingNewAccount: true)
                                    .toolbar {
                                        Button {
                                            info.shouldAddNewAccount = (false, nil)
                                            info.shouldShowAccountChooser = false
                                        } label: {
                                            Image(systemName: "chevron.backward.circle.fill")
                                            Text("Back")
                                        }
                                    }
                            } else {
                                DFMAccountChooserView()
                            }
                        } else if info.keychainItems.count == 0 {
                            LoginScreen(keys: $keys, animate: $launchScreenAnimate)
                        } else if info.keychainItems.count == 1 {
                            if info.shouldAddNewAccount.0 {
                                LoginScreen(keys: $keys, animate: $launchScreenAnimate, addingNewAccount: true)
                                    .toolbar {
                                        Button {
                                            info.shouldAddNewAccount = (false, nil)
                                            info.shouldShowAccountChooser = false
                                        } label: {
                                            Image(systemName: "chevron.backward.circle.fill")
                                            Text("Back")
                                        }
                                    }
                            } else {
                                Button("Login as \(info.keychainItems[0][0])") {
                                    PrintDebug("attempting to log in")
                                    if DFMConstants.DFMSecrets.token != "" {
                                        info.shouldShowAccountChooser = false
                                    } else {
                                        getAccountToken(
                                            from: info
                                                .keychainItems[0][0]
                                        )
                                    }
                                }
                                .toolbar {
                                    if DFMConstants.DFMSecrets.token != "" {
                                        Button {
                                            info.shouldAddNewAccount = (false, nil)
                                            info.shouldShowAccountChooser = false
                                        } label: {
                                            Image(systemName: "chevron.backward.circle.fill")
                                            Text("Back")
                                        }
                                    }
                                }
                                .task {
                                    PrintDebug("It seems it's returning \(info.keychainItems)")
                                }
                                Button("Add another account") {
                                    info.shouldAddNewAccount = (true, nil)
                                    info.shouldShowAccountChooser = true
                                }
                                Button("Log out") {
                                    DFMConstants.DFMSecrets.email = info.keychainItems[0][0]
                                    NotificationCenter.default
                                        .post(name: Notification.Name("DFMLogOutUpdate"), object: nil)
                                }
                            }
                        }
                    } else {
                        if info.loadingScreen.0 {
                            HStack {
                                ProgressView()
                                Text(info.loadingScreen.1)
                            }
                            .padding(5)
                            .frame(height: 30)
                            .animation(.none, value: UUID())
                        } else {
                            ContentView()
                        }
                    }
                }
                .task {
                    if info.shouldLogOut.0 {
                        PrintDebug("should probably log out now")
                        NotificationCenter.default
                            .post(name: Notification.Name("DFMLogOutUpdate"), object: nil)
                        info.shouldLogOut.0 = false
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                grantPermissionForNotifications()
                if !ranOnce {
                    info.keychainItems = UserDefaults.standard.object(forKey: "DFMUserArray") as? [[String]] ?? [[String]]()
                    ranOnce = true
                }
                if info.keychainItems.count == 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.9) {
                        DFMInformation.shared.loadingScreen = (true, "Waiting for authentication")
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            getAccountToken(
                                from: info.keychainItems[0][0]
                            )
                        }
                    }
                } else if keys.count > 1 {
                    showAccountChooser = true
                } else {
                    info.shouldShowAccountChooser = true
                }
            }
            .environmentObject(info)
            #if os(macOS)
            .background(VisualEffectView().ignoresSafeArea())
            #endif
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .commands {
            CommandGroup(replacing: .help) {
                Button {
                    help = true
                } label: {
                    Text("Get Help")
                }

            }
        }
    }
}

//        .onChange(of: controlActiveState) { new in
//            info.isWindowFocused = new == .key
//        }

func getAccountToken(from key: String) {
    PrintDebug("ran get account token")
    do {
        let token = try DFMInformation.shared.keychain.get(key)
        if let token {
            DFMInformation.shared.shouldShowAccountChooser = false
            DFMConstants.DFMSecrets.token = token
            DFMConstants.DFMSecrets.email = key
            DFMInformation.shared.gateway.stop()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                DFMInformation.shared.gateway.start()
            }
            DFMInformation.shared.loadingScreen = (true, "Initialising application")
            DFMInformation.shared.userInfo = nil
            DFMInformation.shared.guildList = nil
            DFMInformation.shared.error = nil
            DFMInformation.shared.userReferences = [:]
            DFMInformation.shared.privateChannels = []
            DFMInformation.shared.presences = []
            DFMInformation.shared.subscribedChannels = Set()
            DFMInformation.shared.messages = [:]
            DFMInformation.shared.liveMessages = [:]
        } else {
            throw DFMError.thrownError("value was nil")
        }
    } catch {
        PrintDebug("there was an error: \(error)")
        DFMInformation.shared.shouldShowAccountChooser = true
    }
}

