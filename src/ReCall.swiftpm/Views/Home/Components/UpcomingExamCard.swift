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
    @State private var showCourseEdit = false
    @State private var showAlert = false
    
    let folder: FolderItem
    
    var body: some View {
        NavigationLink(destination: CourseView(folder: folder)){
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
            }
            .contextMenu {
                Button(action: {
                    folder.favorite = !folder.favorite
                    try? context.save()
                }) {
                    Label(folder.favorite ? "Remove Bookmark" : "Add Bookmark", systemImage: folder.favorite ? "bookmark.fill" : "bookmark")
                }
                Button(action: {
                    showCourseEdit.toggle()
                }) {
                    Label("Edit", systemImage: "pencil")
                }
                Button(role: .destructive, action: {
                    showAlert.toggle()
                }) {
                    Label("Delete", systemImage: "trash")
                }
            }
            .sheet(isPresented: $showCourseEdit) {
                CourseEdit(folder: folder)
                    .presentationDetents([.fraction(0.45)])

            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete this item? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        context.delete(folder)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
