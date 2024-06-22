//
//  DFMUserSelfView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 11/5/2024.
//

import SwiftUI

struct DFMUserSelfView: View {
    @EnvironmentObject var info: DFMInformation
    
    @State var popover = true
    
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
                .popover(isPresented: $popover, arrowEdge: .trailing) {
                    Div {
                        VStack {
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

                        VStack {
                            Button("Log Out") {
                                NotificationCenter.default
                                    .post(name: Notification.Name("DFMLogOutUpdate"), object: nil)
                            }
                            Button("Add another account") {
                                info.shouldAddNewAccount = (true, nil)
                                info.shouldShowAccountChooser = true
                            }
                            Button("Switch Accounts") {
                                info.shouldAddNewAccount = (false, nil)
                                info.shouldShowAccountChooser = true
                                info.shouldChangeAccount = true
                            }
                        }
                    }
                    .frame(minWidth: 200, minHeight: 100)
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
        .onTapGesture {
            popover = true
        }
    }
}
