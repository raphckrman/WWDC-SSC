//
//  FlashcardCard.swift
//  ReCall
//
//  Created by Raphaël on 21/01/2025.
//

import SwiftUI

@available(iOS 17, *)
struct FlashcardCard: View {
    @Environment(\.modelContext) private var context

    var card: FlashcardItem
    var folder: FolderItem
    
    var action: (() -> Void)? = nil
    
    @State private var showCardEdit = false
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            VStack(alignment: .leading) {
                Text(card.question)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                Text(card.answer)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                Spacer()
                    .frame(height: 15)
                HStack {
                    Image(systemName: "calendar")
                    Text(Date().formatted(.dateTime.day().month()))
                    Spacer()
                        .frame(width: 20)
                    Text("|")
                        .fontWeight(.bold)
                    Spacer()
                        .frame(width: 20)
                    Image(systemName: card.difficulty >= 0 ? "star.fill" : "star")
                    Image(systemName: card.difficulty >= 1 ? "star.fill" : "star")
                    Image(systemName: card.difficulty >= 2 ? "star.fill" : "star")
                }
                .foregroundColor(Color(UIColor.gray))
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .frame(maxWidth: 275)
            .contextMenu {
                Button(action: {
                    showCardEdit.toggle()
                }) {
                    Label("Edit", systemImage: "pencil")
                }
                Button(role: .destructive, action: {
                    print("pressed")
                    showAlert.toggle()
                }) {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .buttonStyle(PressableScaleStyle())
        .sheet(isPresented: $showCardEdit) {
            CardEdit(card: card)
                .presentationDetents([.fraction(0.43)])
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this item? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    folder.removeFlashcard(id: card.id)
                },
                secondaryButton: .cancel()
            )
        }
    }
}
