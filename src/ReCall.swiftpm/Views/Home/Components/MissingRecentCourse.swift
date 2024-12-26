//
//  MissingRecentCourse.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI

struct MissingRecentCourse: View {
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                VStack(alignment: .center, spacing: 7) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.primary.opacity(0.5))
                    Text("Create my first course!")
                        .font(.headline)
                        .foregroundColor(.primary.opacity(0.5))
                }
                .padding(.all, 30)
            }
            .frame(height: 125)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
        }
        .buttonStyle(PressableScaleStyle())
    }
}
