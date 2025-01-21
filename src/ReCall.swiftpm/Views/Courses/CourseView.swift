//
//  CourseView.swift
//  ReCall
//
//  Created by Raphaël on 04/01/2025.
//

import SwiftUI

@available(iOS 17, *)
struct CourseView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State private var showCourseEdit = false
    @State private var showCourseAlert = false
    @State private var showCardCreate = false

    var folder: FolderItem
    var body: some View {
        BaseView(title: folder.name) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "clock.fill")
                        Text("Last time this was reviewed: \(folder.lastReviewedDate.formatted(.dateTime.day().month().year()))")
                            .font(.body)
                    }
                    .opacity(0.7)
                    .frame(alignment: .leading)
                    HStack {
                        Image(systemName: "flame.fill")
                        Text("Reviewed this course for 3 days in a row!")
                            .font(.body)
                    }
                    .opacity(0.7)
                    .frame(alignment: .leading)
                    CourseAlert(icon: "checkmark.seal.fill", text: "Great job! You’ve studied recently, take a break!", color: .green)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                //CourseAlert(icon: "exclamationmark.triangle.fill", text: "Your exam is fast approaching, just 3 days to go.", color: .red)
                    //.padding(.top)
                //CourseAlert(icon: "clock.fill", text: "You haven't reviewed in a while, it's time to get back on track!", color: .orange)
                
                sectionTitle(title: "Flashcards") {
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            Spacer()
                            ForEach(folder.flashcards, id: \.id) { flashcard in
                                FlashcardCard(question: flashcard.question, answer: flashcard.answer, difficulty: flashcard.difficulty)
                            }
                            Spacer()
                        }
                    }
                } toolbarContent: {
                    AnyView(
                        HStack {
                            Button("", systemImage: "plus.circle") {
                                showCardCreate.toggle()
                            }
                        }
                    )
                }
                sectionTitle(title: "Improvements") {
                    ContentUnavailableView("No Improvements", systemImage: "chart.pie", description: Text("Study to get help!"))
                }
                sectionTitle(title: "Badges") {
                    ContentUnavailableView("No Badges", systemImage: "play.circle", description: Text("Study to earn badges!"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } toolbarContent: {
            AnyView(
                HStack {
                    Button(folder.favorite ? "Remove Bookmark" : "Add Bookmark", systemImage: folder.favorite ? "bookmark.fill" : "bookmark") {
                        folder.favorite = !folder.favorite
                        try? context.save()
                    }
                    Button("Learn", systemImage: "play") {
                        print("Learn")
                    }
                    Button("Delete", systemImage: "trash") {
                        showCourseAlert.toggle()
                    }
                    Button("Edit", systemImage: "gearshape") {
                        showCourseEdit.toggle()
                    }
                }
            )
        }
        .sheet(isPresented: $showCardCreate) {
            CardCreate(folder: folder)
                .presentationDetents([.fraction(0.43)])
        }
        .sheet(isPresented: $showCourseEdit) {
            CourseEdit(folder: folder)
                .presentationDetents([.fraction(0.45)])
        }
        .alert(isPresented: $showCourseAlert) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this item? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    context.delete(folder)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
