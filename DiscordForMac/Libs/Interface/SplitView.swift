//
//  SplitView.swift
//  DiscordForMac
//
//  Created by Adithiya Venkatakrishnan on 14/06/2024.
//
//  credits to this guy on stackoverflow (meh he used C-code-formatting which is ugly)
//  Created by Darren Oakey on 3/8/20.
//  Copyright © 2020 Darren Oakey. All rights reserved.

import SwiftUI

struct SplitView<Left: View, Right: View>: View {
    @State var left: () -> Left
    @State var right: () -> Right
    
    @State var splitterWidth = 10
    @State var splitterLocation = 200
    @State var originalLocation = 0
    @State var dragging = false
    @State var offset: CGFloat = 0

    var splitterLocationComputed: Int {
        if dragging {
            return originalLocation + Int( offset)
        }
        return splitterLocation
    }
    
    func dragChange(gesture: DragGesture.Value) {
        if (!self.dragging) {
            self.originalLocation = self.splitterLocation
            self.dragging = true
        }
        PrintDebug(gesture.location.x + offset - gesture.startLocation.x)
        if gesture.location.x + offset - gesture.startLocation.x < 10 && gesture.location.x + offset - gesture.startLocation.x > -60 {
            self.offset = gesture.location.x + offset - gesture.startLocation.x
        }
    }

    func dragDone(gesture: DragGesture.Value) {
        self.dragging = false
        self.splitterLocation += Int(self.offset)
        self.offset = 0
    }
    
    var body: some View {
        GeometryReader() { geometry in
            HStack(spacing: 0) {
                left()
                    .frame(
                        width: CGFloat(self.splitterLocationComputed),
                        height: geometry.size.height
                    )
                ZStack {
                    Spacer()
                        .frame(width: 10)
                        .background(Color.clear)
                    Spacer()
                        .frame(width: 1)
                        .background(Color.gray)
                }
//                .background(Color.white)
                .frame(
                    width:
                        CGFloat(10),
                    height: CGFloat(geometry.size.height)
                )
                .onHover {inside in
                    if inside {
                        NSCursor.resizeLeftRight.push()
                    } else {
                        NSCursor.pop()
                    }
                }
                .gesture(DragGesture().onChanged(dragChange).onEnded(dragDone)
                )
                right()
                    .frame(
                        width: geometry.size.width - CGFloat(self.splitterWidth + self.splitterLocationComputed),
                        height: geometry.size.height
                    )
            }
        }
    }
}

// had to remove the preview
// cuz the sound of the notifications
// was driving me crazy. crazy?

// also it might overload (identify) requests to discord gateway
// and im tryna not get banned
