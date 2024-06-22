//
//  ContentView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 9/5/2024.
//

import SwiftUI

enum DFMErrorType {
    case APIParseFailure
    case InternetFailure
    case InternalFailure
    
    case GatewayFailure
    
    case UnknownFailure
}

struct DFMErrorViewInfo {
    var error: String
    var code: DFMErrorType = .UnknownFailure
    var fatal: Bool = false
}

struct ContentView: View {
    @EnvironmentObject var info: DFMInformation
    @State var selectedGuild: DFMGuildViewData?
    @State var selectedChannel: DFMChannel?
    
    let passable = DFMGuildViewData(
        guild: DFMGuild(id: Snowflake(0), dms: true),
        categoryOrganisedChannels: []
    )
    
    var body: some View {
        NavigationSplitView {
            VStack {
                DFMUserSelfView()
                Spacer()
                Divider()
                List(selection: $selectedGuild) {
                    NavigationLink(value: passable) {
                        HStack {
                            Image(systemName: "person.3.fill")
                                .frame(width: 40, height: 40, alignment: .center)
                                .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                .cornerRadius(10)
                                .minimumScaleFactor(0.5)
                            Text("Direct Messages")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                    }
                    #if os(macOS)
                    Divider()
                    #endif
                    DFMGuildListView(selectedGuild: $selectedGuild)
                }
            }
            .navigationSplitViewColumnWidth(min: 130, ideal: 215, max: 300)
            .navigationTitle("DiscordForMac")
        } content: {
            Div {
                if let selectedGuild {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                if selectedGuild.guild.id == 0 {
                                    Image(systemName: "person.3.fill")
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                        .cornerRadius(10)
                                        .minimumScaleFactor(0.5)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } else if let iconURL = selectedGuild.guild.iconURL {
                                    DFMImageView(url: iconURL)
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(10)
                                        .id(UUID())
//                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } else {
                                    Text("\(NSRegularExpression( "(?:^|\\s)([\\P{Cc}\\P{Cs}\\P{Cn}])").matchesGroup(selectedGuild.guild.name))")
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                        .cornerRadius(10)
                                        .minimumScaleFactor(0.5)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Text(selectedGuild.guild.name)
                                    .bold()
                                    .font(.title3)
                                    .multilineTextAlignment(.leading)
                                    .zIndex(50)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Divider()
                        }
                        .padding([.horizontal, .top])
                        if selectedGuild.guild.id == 0 {
                            DFMPrivateChannelView(selectedChannel: $selectedChannel)
                                .zIndex(1)
                        } else {
                            DFMChannelListView(selectedGuild: selectedGuild, selectedChannel: $selectedChannel)
                                .zIndex(1)
                        }
                    }
                }
            }
            .padding(.bottom, -40)
            .offset(y: -40)
            .navigationSplitViewColumnWidth(min: 130, ideal: 215, max: 300)
            .navigationTitle(selectedGuild?.guild.name ?? "")
        } detail: {
            Div {
                if let selectedChannel {
                    DFMMessageView(selectedChannel: selectedChannel)
                }
            }
            .navigationSplitViewColumnWidth(min: 400, ideal: 500)
            .navigationTitle(selectedChannel?.name ?? "")
        }
        
    }
}
