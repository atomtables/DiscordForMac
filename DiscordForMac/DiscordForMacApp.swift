//
//  DiscordForMacApp.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 9/5/2024.
//

import SwiftUI

@main
struct DiscordForMacApp: App {
    @StateObject var info: DFMInformation = DFMInformation.shared
    @AppStorage("DFMWelcomeScreenShown", store: UserDefaults(suiteName: "dev.atomtables.DiscordForMac.internal")) var welcomeScreenShown: Bool = false
    
    @State var help = false
    
    init() {
        Task {
            DFMUserUpdater()
            DFMGuildsUpdater()
            await DFMUserReferenceUpdater()
            await DFMPrivateChannelsUpdater()
            DFMPresencesUpdater()
            DFMMessageUpdater()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if let error = info.error {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .padding(1)
                        .scaleEffect(2)
                    Text("There was an error loading data.")
                        .font(.title2)
                    Text(error.error)
//                    if error.code == .GatewayFailure {
//                        Button("Attempt to reconnect") {
//                            info.gateway = DFMGatewayConnectionSocket()
//                            info.setLoadingScreen((true, "Connecting to the server"))
//                            info.gateway.start()
//                            info.error = nil
//                        }
//                    }
                }
                .task {
                    if error.code == .GatewayFailure {
                        DFMInformation.shared.gateway = nil
                    }
                }
            } else {
                if welcomeScreenShown {
                    if info.loadingScreen.0 {
                        VStack {
                            AppIcon()
                            HStack {
                                ProgressView()
                                    .padding(2)
                                Text("\(info.loadingScreen.1)...")
                                    .fontWeight(.semibold)
                            }
                        }
                        .task {
                            DFMInformation.shared.gateway.start()
                            info.setLoadingScreen((true, "Connecting to the server"))
                        }
                    } else {
                        ContentView()
                            .environmentObject(info)
                            .alert(isPresented: $help) {
                                Alert(title: Text("Help"), message: Text("Help Yourself."))
                            }
                    }
                } else {
                    VStack {
                        Text("Welcome to DiscordForMac!")
                        Button {
                            welcomeScreenShown = true
                        } label: {
                            Text("Begin")
                        }
                    }
                }
            }
            
        }
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


