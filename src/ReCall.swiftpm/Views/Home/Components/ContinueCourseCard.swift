//
//  ContinueCourseCard.swift
//  ReCall
//
//  Created by Raphaël on 28/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct ContinueCourseCard: View {
    @Environment(\.modelContext) private var context
    @State private var showCourseEdit = false
    @State private var showAlert = false

    var folder: FolderItem

    var body: some View {
        NavigationLink(destination: CourseView(folder: folder)) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(folder.subject)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text(folder.name)
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        let totalFlashcards = folder.flashcards.count
                        let reviewedFlashcards = folder.flashcards.filter { $0.nextReview > Date() }.count

                        let percentageReviewed: Double = totalFlashcards > 0 ? (Double(reviewedFlashcards) / Double(totalFlashcards)) * 100 : 0

                        Text("\(totalFlashcards) Flashcards • \(Int(percentageReviewed))%")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary.opacity(0.6))
                            .padding(.top, 30)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(width: 50)
                    VStack(alignment: .leading) {
                        Image(systemName: getIconFromString(word: folder.subject))
                            .font(.system(size: 24))
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.accentColor)
                            .background(Color.accentColor.opacity(0.2))
                            .clipShape(Circle())
                        Spacer()
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.vertical, 5)
                .padding(.top, 10)

                HStack {
                    Spacer()
                }
                .frame(height: 15)
                .background(Color.accentColor)
            }
            .frame(height: 125)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
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
        .buttonStyle(PressableScaleStyle())
    }
}
