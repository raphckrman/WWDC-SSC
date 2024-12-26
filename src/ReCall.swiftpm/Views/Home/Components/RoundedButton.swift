//
//  RoundedButton.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

struct RoundedButton: View {
    var title: String
    var width: CGFloat
    var primary: Bool = true
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                Text(title)
                    .foregroundColor(primary ? .primary : .primary.opacity(0.6))
                    .fontWeight(.semibold)
            }
            .frame(width: width)
            .padding()
            .background(primary ? Color.accentColor : Color.clear)
            .cornerRadius(100)
        }
        .buttonStyle(PressableScaleStyle())
    }
}
