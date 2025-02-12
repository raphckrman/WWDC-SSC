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
    var resetOffset: Bool
    
    var card: FlashcardItem
    var onSwipe: ((FlashcardItem, Bool) -> Void)?
    
    var width = CGFloat(320)
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: width, height: 420)
                .foregroundColor(Color(UIColor.systemBackground))
                .cornerRadius(3)
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
                    offset = gesture.translation
                }
                .onEnded { _ in
                    withAnimation {
                        swipe(width: offset.width)
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
