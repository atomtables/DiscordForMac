//
//  DFMGuildListView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import SwiftUI

struct DFMGuildListView: View {
    @EnvironmentObject var info: DFMInformation
    @Binding var selectedGuild: DFMGuildViewData?
    
    var body: some View {
        if let guildList = info.guildList {
            ForEach(guildList, id: \.guild.id) { guild in
                NavigationLink(value: guild) {
                    HStack {
                        if let iconURL = guild.guild.iconURL {
                            DFMImageView(url: iconURL)
                                .frame(width: 40, height: 40)
                                .cornerRadius(10)
                        } else {
                            Text("\(NSRegularExpression( "(?:^|\\s)([\\P{Cc}\\P{Cs}\\P{Cn}])").matchesGroup(guild.guild.name))")
                                .frame(width: 40, height: 40, alignment: .center)
                                .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                .cornerRadius(10)
                                .minimumScaleFactor(0.5)
                        }
                        // (?:^|\s)([\P{Cc}\P{Cs}\P{Cn}])
                        VStack(alignment: .leading) {
                            Text(guild.guild.name)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("\(guild.guild.approximateMemberCount ?? 0) \(guild.guild.approximateMemberCount == 1 ? "user" : "users") in server")
                        }
                    }
                }
            }
        } else {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView("Loading servers...")
                        .task {
                            //await getDFMGuildsList()
                        }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

