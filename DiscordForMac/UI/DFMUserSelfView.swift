//
//  DFMUserSelfView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import SwiftUI

struct DFMUserSelfView: View {
    @EnvironmentObject var info: DFMInformation
    
    var selectedGuild: Binding<DFMGuild>?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let user = info.userInfo {
                HStack {
                    DFMImageView(url: user.avatarURL)
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text(user.globalName ?? user.username)
                            .fontWeight(.bold)
                            .font(.title3)
                        Text(user.username)
                    }
                }
            }
            else {
                HStack {
                    ProgressView()
                        .frame(width: 40, height: 40, alignment: .center)
                    Text("Loading...")
                }
            }
        }
        .padding(.bottom, 5)
        .padding(.horizontal)
        .padding(.top)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              alignment: .leading
            )
    }
}
