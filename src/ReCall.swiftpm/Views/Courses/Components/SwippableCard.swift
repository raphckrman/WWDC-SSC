//
//  SwippableCard.swift
//  ReCall
//
//  Created by Raphaël on 27/01/2025.
//

import SwiftUI

@available(iOS 17, *)
struct SwippableCard: View {
    @State private var offset = CGSize.zero
    @State private var isFlipped = false
    @State private var showIcon = false
    var resetOffset: Bool

    var card: FlashcardItem
    var onSwipe: ((FlashcardItem, Bool) -> Void)?

    var width: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 520 : 320
    }

    var swipeDirection: String? {
        if offset.width > 50 {
            return "plus"
        } else if offset.width < -50 {
            return "minus"
        }
        return nil
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: width, height: width * 1.3)
                .foregroundColor(Color(UIColor.systemBackground))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 3)
                )

            VStack {
                if isFlipped {
                    Text(card.question)
                        .lineLimit(0)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.primary.opacity(0.5))
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    Divider()
                        .frame(width: 150)
                    Text(card.answer)
                        .lineLimit(10)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                } else {
                    Text(card.question)
                        .lineLimit(0)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                }
            }
            .frame(width: width * 0.95)
            
            if let direction = swipeDirection {
                Image(systemName: direction == "plus" ? "plus.circle.fill" : "minus.circle.fill")
                    .foregroundColor(direction == "plus" ? .green : .red)
                    .font(.system(size: 30))
                    .opacity(showIcon ? 1 : 0)
                    .animation(.easeInOut(duration: 0.2), value: showIcon)
                    .offset(
                        x: direction == "plus" ? -width / 2 + 30 : width / 2 - 30,
                        y: -width * 1.3 / 2 + 30
                    )
            }
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .onChange(of: resetOffset) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                if resetOffset {
                    offset = .zero
                }
            }
        }
        .rotation3DEffect(
            .degrees(isFlipped ? -180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .transition(.scale(scale: 1))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = isFlipped ? CGSize(width: -gesture.translation.width, height: gesture.translation.height) : gesture.translation
                    withAnimation {
                        showIcon = swipeDirection != nil
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipe(width: offset.width)
                        showIcon = false
                    }
                }
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isFlipped.toggle()
            }
        }
    }

    func swipe(width: CGFloat) {
        let width = isFlipped ? -width : width
        switch width {
        case -500...(-100):
            onSwipe?(card, false)
            offset = CGSize(width: -500, height: 0)
            isFlipped = false
        case 100...(500):
            onSwipe?(card, true)
            offset = CGSize(width: 500, height: 0)
            isFlipped = false
        default:
            offset = .zero
        }
    }
}
