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
    @AppStorage("DFMWelcomeScreenShown", store: UserDefaults(suiteName: "dev.atomtables.DiscordForMac.internalf")) var welcomeScreenShown: Bool = false
    
    @State var help = false
    @State var animate = false
    @State var welcomeScreenWasShown = false
    @State var showBeginButton = false
    @State var showLoading = false
    
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
            Group {
                if let error = info.error {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .padding(1)
                            .scaleEffect(2)
                        
                        Text("There was an error loading data.")
                            .font(.title2)
                        
                        Text(error.error)
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
                                Spacer()
                                
                                HStack {
                                    AppIcon()
                                        .frame(width: 64, height: 64)
                                        .scaledToFit()
                                    VStack(alignment: .leading) {
                                        Text("DiscordForMac")
                                            .bold()
                                            .font(.title2)
                                        Text("by atomtables")
                                            .fontWeight(.light)
                                            .font(.headline)
                                    }
                                        .offset(x: -5)
                                }
                                .offset(y: animate ? 0 : 100)
                                .opacity(animate ? 1 : 0)
                                .animation(.easeOut(duration: 1.0), value: animate)
                                .onAppear {
                                    animate = true
                                }
                                .padding(5)
                                
                                HStack {
                                    ProgressView()
                                    Text(info.loadingScreen.1)
                                }
                                .offset(y: showLoading ? 0 : 25)
                                .opacity(showLoading ? 1 : 0)
                                .animation(.easeOut(duration: 1.0), value: showLoading)
                                .padding(5)
                                .frame(height: 30)
                                
                                Spacer()
                            }
                            .task {
                                if welcomeScreenWasShown {
                                    showLoading = true
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                        DFMInformation.shared.gateway.start()
                                        info.setLoadingScreen((true, "Connecting to the server"))
                                    }
                                } else {
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                        showLoading = true
                                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                            DFMInformation.shared.gateway.start()
                                            info.setLoadingScreen((true, "Connecting to the server"))
                                        }
                                    }
                                }
                            }
                        } else {
                            ContentView()
                                .environmentObject(info)
                        }
                    } else {
                        VStack {
                            Spacer()
                            
                            HStack {
                                AppIcon()
                                    .frame(width: 64, height: 64)
                                    .scaledToFit()
                                VStack(alignment: .leading) {
                                    Text("DiscordForMac")
                                        .bold()
                                        .font(.title2)
                                    Text("by atomtables")
                                        .fontWeight(.light)
                                        .font(.headline)
                                }
                                    .offset(x: -5)
                            }
                            .offset(y: animate ? 0 : 100)
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: 1.0), value: animate)
                            .onAppear {
                                animate = true
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                    showBeginButton = true
                                }
                            }
                            .padding(5)
                            
                            Button {
                                showBeginButton = false
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                    welcomeScreenShown = true
                                    welcomeScreenWasShown = true
                                }
                            } label: {
                                Text("Begin")
                            }
                            .offset(y: showBeginButton ? 0 : 25)
                            .opacity(showBeginButton ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: showBeginButton)
                            .padding(5)
                            .frame(height: 30)
                            
                            Spacer()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
#if os(macOS)
            .background(VisualEffectView().ignoresSafeArea())
#endif
            .alert(isPresented: $help) {
                Alert(title: Text("Help"), message: Text("Help Yourself."))
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


