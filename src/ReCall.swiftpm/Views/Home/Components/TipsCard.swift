//
//  TipsCard.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

struct TipsCard: View {
    var action: (() -> Void)? = nil
    var sentence: String

    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack(alignment: .topLeading) {
                Color(UIColor.secondarySystemBackground)
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "questionmark.circle.dashed")
                            .font(.title2)
                            .foregroundColor(.primary.opacity(0.5))
                        Text("Tips")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary.opacity(0.5))
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 10)

                    Spacer()

                    HStack(alignment: .center) {
                        Text(sentence)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.primary.opacity(0.5))
                            .padding(.horizontal, 7)
                            .padding(.bottom, 15)
                            .frame(maxWidth: 240)
                    }
                }
            }
            .frame(height: 125)
        }
        .buttonStyle(PressableScaleStyle())
    }
}
