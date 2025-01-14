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
    let toolbarContent: AnyView?

    init(title: String, @ViewBuilder content: () -> Content, toolbarContent: (() -> AnyView)? = nil) {
        self.title = title
        self.content = content()
        self.toolbarContent = toolbarContent?()
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
            .toolbar {
                if let toolbarContent = toolbarContent {
                    toolbarContent
                }
            }
        }
    }
}

struct sectionTitle<Content: View>: View {
    let title: String
    let content: () -> Content
    let toolbarContent: (() -> AnyView)?

    init(title: String, @ViewBuilder content: @escaping () -> Content, toolbarContent: (() -> AnyView)? = nil) {
        self.title = title
        self.content = content
        self.toolbarContent = toolbarContent
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                if let toolbarContent = toolbarContent {
                    Spacer()
                    toolbarContent()
                }
            }
            .padding(.horizontal)

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
}
