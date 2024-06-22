//
//  DFMChannelListView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 16/05/2024.
//

import SwiftUI

struct DFMChannelListView: View {
    var selectedGuild: DFMGuildViewData
    @Binding var selectedChannel: DFMChannel?
    
    var body: some View {
        List(selectedGuild.categoryOrganisedChannels, id: \.category.id, selection: $selectedChannel) { categoryOrganisedChannel in
            if categoryOrganisedChannel.category.name != "   Unlabeled Channels" {
                Section(header: Text(categoryOrganisedChannel.category.name ?? "Unlabeled Header")) {
                    ForEach(categoryOrganisedChannel.channels) { channel in
                        NavigationLink(value: channel) {
                            Text(channel.name ?? "")
                        }
                    }
                }
            } else {
                ForEach(categoryOrganisedChannel.channels) { channel in
                    NavigationLink(value: channel) {
                        Text(channel.name ?? "")
                    }
                }
            }
        }
    }
}

