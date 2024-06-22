//
//  DFMMessageView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 03/06/2024.
//

import SwiftUI

/// `DFMMessageView` also has the job of sending messages and verifying they were sent.
@available(macOS 12, *)
struct DFMMessageView: View {
    @EnvironmentObject var info: DFMInformation
    @State var messageText: String = ""
    let selectedChannel: DFMChannel
    
    var body: some View {
        if let messages = info.combinedMessages[selectedChannel.id] {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(Array(messages.enumerated()), id: \.1.id) { (idx, message) in
                        if idx == 0 || areSameDay(date1: messages[idx - 1].timestamp, date2: message.timestamp) {
                            
                        }
                        HStack(alignment: .top) {
                            if let avatarURL = message.author?.avatarURL {
                                DFMImageView(url: avatarURL)
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .cornerRadius(10)
                            }
                            VStack(alignment: .leading) {
                                Text("\((message.author?.globalName ?? message.author?.username) ?? "Unknown Author") • \(message.id.toDate().ISO8601Format())")
                                Text(message.content ?? "*EMPTY MESSAGE*")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                            }
                        }
                        .transition(.move(edge: .top)) // Slide in from the bottom
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .scaleEffect(x: 1, y: -1, anchor: .center)
                    .animation(.easeOut(duration: 0.5), value: UUID())  // its deprecated but i dont see another solution (or feel like finding one)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom)
            .scaleEffect(x: 1, y: -1, anchor: .center)
            
            HStack {
                TextField("Message", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    let textMessage = messageText.copy() as! String
                    Task {
                        do {
                            try await SendMessage(selectedChannel.id, textMessage: textMessage)
                            messageText = ""
                        } catch {
                            fatalError("\(error)")
                        }
                    }
                    messageText = ""
                }
            }
            .padding(5)
        } else {
            HStack {
                ProgressView()
                    .padding(2)
                Text("Loading messages...")
            }.task {
                if selectedChannel.id != 0 {
                    info.subscribedChannels.insert(selectedChannel.id)
                    print(info.subscribedChannels)
                    
                    let messages = try! await GetMessages(selectedChannel.id)
                    info.addMessages(selectedChannel.id, messages)
                }
            }
        }
    }
    
}

