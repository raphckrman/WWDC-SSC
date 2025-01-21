//
//  TextEditorView.swift
//  ReCall
//
//  Created by Raphaël on 18/01/2025.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    @FocusState private var isAnswerFocused: Bool

    var body: some View {
        TextField("Answer", text: $text, axis: .vertical)
            .lineLimit(7, reservesSpace: true)
            .textFieldStyle(.roundedBorder)
            .focused($isAnswerFocused)
            .border(.clear)
            .toolbar {
                if isAnswerFocused {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("", systemImage: "document.viewfinder") {
                        isAnswerFocused = false
                    }
                    .foregroundColor(.primary)
                    Button("", systemImage: "paperclip") {
                        isAnswerFocused = false
                    }
                    .foregroundColor(.primary)
                    Button("", systemImage: "link") {
                        isAnswerFocused = false
                    }
                    .foregroundColor(.primary)
                    Spacer()
                }
            }
        }
    }
}
