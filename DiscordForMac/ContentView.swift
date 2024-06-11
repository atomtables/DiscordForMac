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
            
        } content: {
            if let selectedGuild {
                if selectedGuild.guild.id == 0 {
                    DFMPrivateChannelView(selectedChannel: $selectedChannel)
                } else {
                    DFMChannelListView(selectedGuild: selectedGuild, selectedChannel: $selectedChannel)
                }
            } else {
                Text("\(selectedGuild?.guild.name ?? "content")")
            }
        } detail: {
            if let selectedChannel {
                DFMMessageView(selectedChannel: selectedChannel)
            }
        }.navigationTitle(selectedGuild?.guild.name ?? "")
        
    }
}
