//
//  DFMMessageView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 03/06/2024.
//

import SwiftUI

/// `DFMMessageView` also has the job of sending messages and verifying they were sent.
struct DFMMessageView: View {
    @EnvironmentObject var info: DFMInformation
    
    @State private var scrollPosition: CGPoint = .zero
    @State private var scrollHeight: CGFloat = .zero
    
    @State var messageText: String = ""
    
    @State var loadingMessages: Bool = false

    let selectedChannel: DFMChannel
    
    var mdyDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter
    }
    
    var timeDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale.current
        return dateFormatter
    }
    
    var body: some View {
        if let messages = info.combinedMessages[selectedChannel.id] {
            Div {
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                            .cornerRadius(10)
                            .minimumScaleFactor(0.5)
                        Text(selectedChannel.name ?? "empty channel name")
                            .bold()
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .zIndex(50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                }
                .padding([.horizontal, .top])
                .offset(y: -40)

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(Array(messages.enumerated()), id: \.1.id) { (idx, message) in
                            HStack(alignment: .top) {
                                if let avatarURL = message.author?.avatarURL {
                                    DFMImageView(url: avatarURL)
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .cornerRadius(10)
                                }
                                VStack(alignment: .leading) {
                                    Text("\((message.author?.globalName ?? message.author?.username) ?? "Unknown Author") • \(timeDateFormatter.string(from: message.id.toDate()))")
                                    Text(message.content ?? "*EMPTY MESSAGE*")
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                }
                            }
                            .transition(.move(edge: .top)) // Slide in from the bottom
                            if message != messages.last && !areSameDay(date1: messages[idx + 1].timestamp, date2: message.timestamp) {
                                DividerWithLabel(label: mdyDateFormatter.string(from: messages[idx].timestamp))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                        .animation(.easeOut(duration: 0.5), value: UUID())
                        .transition(.push(from: .bottom))
                        HStack {
                            Spacer()
                            ProgressView()
                                .scaleEffect(x: 1, y: -1, anchor: .center)
                            Spacer()
                        }
                    }
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                            .preference(key: ScrollHeightPreferenceKey.self, value: geometry.size.height)
                    })
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        self.scrollPosition = value
#if os(macOS)
                        if abs(value.y-375) > scrollHeight {
                            Task {
                                if !loadingMessages {
                                    loadingMessages = true
                                    let messages = try! await GetMessages(selectedChannel.id, before: messages.last?.id)
                                    info.addMessages(selectedChannel.id, messages)

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        loadingMessages = false
                                    }
                                }
                            }
                        }
#elseif os(iOS)
                        if abs(value.y-800) > scrollHeight {
                            Task {
                                if !loadingMessages {
                                    loadingMessages = true
                                    let messages = try! await GetMessages(selectedChannel.id, before: messages.last?.id)
                                    info.addMessages(selectedChannel.id, messages)

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        loadingMessages = false
                                    }
                                }
                            }
                        }
#endif
                    }
                    // 2582 -2240 = 342
                    // 2607 -2265 = 342
                    // 2501 -2159 = 342
                    // 2713 -2371 = 342
                    // a constant of 342 (prob make it 375 for the best)
                    // on ios make it larger (to 800)
                    .onPreferenceChange(ScrollHeightPreferenceKey.self) { value in
                        scrollHeight = value
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .coordinateSpace(name: "scroll")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom)
                .scaleEffect(x: 1, y: -1, anchor: .center)
                .padding(.top, -60)

                HStack {
                    TextField("Message", text: $messageText)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") {
                        let textMessage = messageText.copy() as! String
                        Task {
                            let _ = try! await SendMessage(selectedChannel.id, textMessage: textMessage)
                            messageText = ""
                        }
                        messageText = ""
                    }
                }
                .padding(5)
            }
        } else {
            HStack {
                ProgressView()
                    .padding(2)
                Text("Loading messages...")
            }.task {
                loadingMessages = true
                if selectedChannel.id != 0 {
                    info.subscribedChannels.insert(selectedChannel.id)
                    PrintDebug(info.subscribedChannels)

                    let messages = try! await GetMessages(selectedChannel.id)
                    info.addMessages(selectedChannel.id, messages)
                    loadingMessages = false
                }
            }
        }
    }
    
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct ScrollHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
