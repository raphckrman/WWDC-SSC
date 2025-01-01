//
//  UpcomingExamCard.swift
//  ReCall
//
//  Created by Raphaël on 28/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct UpcomingExamCard: View {
    @Environment(\.modelContext) private var context

    let folder: FolderItem
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(folder.subject)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(folder.name)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    if (folder.examDate != nil) {
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundColor(.primary)
                            
                            Text(daysUntilText(from: folder.examDate!))
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        .opacity(0.8)
                        .padding(.top, 10)
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primary.opacity(0.2))
                }
            }
            .contextMenu {
                Button(action: {
                    print("Bookmark")
                }) {
                    Label("Add Bookmark", systemImage: "star")
                }

                Button(action: {
                    print("Edit")
                }) {
                    Label("Edit", systemImage: "pencil")
                }
                Button(role: .destructive, action: {
                    context.delete(folder)
                }) {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}
