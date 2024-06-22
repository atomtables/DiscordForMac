//
//  DFMPrivateChannelView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 17/05/2024.
//

import SwiftUI

struct DFMPrivateChannelView: View {
    @EnvironmentObject var info: DFMInformation
    @Binding var selectedChannel: DFMChannel?
    
    var body: some View {
        VStack(alignment: .leading) {
            List(selection: $selectedChannel) {
                ForEach(info.privateChannels) { privateChannel in
                    NavigationLink(value: privateChannel) {
                        if privateChannel.singleUserDM {
                            if let avatarURL = privateChannel.recipients?[0].avatarURL {
                                DFMImageView(url: avatarURL)
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .cornerRadius(10)
                            } else {
                                Image(systemName: "person.crop.circle.badge.questionmark.fill")
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                    .cornerRadius(10)
                                    .minimumScaleFactor(0.5)
                            }
                        } else {
                            if let iconURL = privateChannel.groupIconURL {
                                DFMImageView(url: iconURL)
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .cornerRadius(10)
                            } else {
                                Image(systemName: "person.2.fill")
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                    .cornerRadius(10)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(privateChannel.name ?? (privateChannel.recipients?.map { recipient in
                                return recipient.globalName ?? recipient.username
                            }.joined(separator: ", "))!)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            if privateChannel.groupDM {
                                Text("\((privateChannel.recipients?.count ?? 0) + 1) members")
                            } else {
                                Text("\(DFMPrivateChannelFindUserPresence(privateChannel.recipients?[0].id)?.getStatus() ?? "Offline")")
                                    .lineLimit(1)
                            }
                        }
                    }
#if os(macOS)
                    .padding(5)
#endif
                }
            }
#if os(macOS)
            .listRowBackground(VisualEffectView().ignoresSafeArea())
            .scrollContentBackground(.hidden)
#endif
        }
    }
    
    func DFMPrivateChannelFindUserPresence(_ user: Snowflake! = Snowflake(0)) -> DFMPresence? {
        return info.presences.first { presence in
            presence.user.id == user
        }
    }
}



//#Preview {
//    DFMPrivateChannelView()
//        .environmentObject(DFMInformation.shared)
//}
