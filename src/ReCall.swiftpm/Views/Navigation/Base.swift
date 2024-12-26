//
//  Base.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI

struct BaseView<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                content
            }
            .scrollIndicators(.hidden)
            .background(Color.gray.opacity(0.1))
            .background(
                LinearGradient(
                    colors: [.accentColor.opacity(0.2), .clear, .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
            .navigationSplitViewColumnWidth(0)
            .frame(maxWidth: .infinity)
        }
    }
}

@ViewBuilder
func sectionTitle(_ title: String, @ViewBuilder content: () -> some View) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal)
        content()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.bottom)
}
