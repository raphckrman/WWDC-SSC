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
    @State private var showCardCreate: Bool = false
    @State private var isStudying: Bool = false
    @State private var finishedToReview = false
    @State private var learnedCardsCount: Int = 0

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
                    if folder.reviewCount > 1 {
                        HStack {
                            Image(systemName: "flame.fill")
                            Text("You have reviewed this folder \(folder.reviewCount) times.")
                                .font(.body)
                        }
                        .opacity(0.7)
                        .frame(alignment: .leading)
                    }
                    let daysBeforeExam = folder.examDate.map { Calendar.current.dateComponents([.day], from: Date(), to: $0).day ?? 0 } ?? 0
                    if daysBeforeExam < 7 && daysBeforeExam != 0 && daysBeforeExam > 0 {
                        CourseAlert(icon: "exclamationmark.triangle.fill", text: "Your exam is fast approaching, just \(daysBeforeExam) days to go.", color: .red)
                    } else {
                        if folder.nextReviewDate < Date() {
                            CourseAlert(icon: "clock.fill", text: "You haven't reviewed in a while, it's time to get back on track!", color: .orange)
                        } else {
                            CourseAlert(icon: "checkmark.seal.fill", text: "Great job! You’ve studied recently, take a break!", color: .green)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                sectionTitle(title: "Flashcards") {
                        ScrollView(.horizontal) {
                            HStack(spacing: 12) {
                                Spacer()
                                if folder.flashcards.isEmpty {
                                    MissingRecentCourse(action: {
                                        showCardCreate.toggle()
                                    }, title: "Create the first flashcard!")
                                } else {
                                    ForEach(folder.flashcards, id: \.id) { flashcard in
                                        FlashcardCard(card: flashcard, folder: folder)
                                            .transition(.move(edge: .trailing))
                                            .animation(.easeInOut(duration: 0.3), value: folder.flashcards)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.vertical, 20)
                    }
                        .padding(.vertical, -20)

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
                    if folder.flashcards.isEmpty {
                        ContentUnavailableView("No Improvements", systemImage: "chart.pie", description: Text("Learn to unlock improvements!"))
                            .padding(.top)
                    } else {
                        ScrollView(.horizontal) {
                            HStack(spacing: 12) {
                                Spacer()
                                ForEach(folder.flashcards.sorted(by: { $0.nextReview > $1.nextReview }), id: \.id) { flashcard in
                                    FlashcardCard(card: flashcard, folder: folder)
                                        .transition(.move(edge: .trailing))
                                        .animation(.easeInOut(duration: 0.3), value: folder.flashcards)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 30)
                        }
                        .padding(.vertical, -30)
                    }
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
                    if !folder.flashcards.isEmpty {
                        NavigationLink(destination: LearningView(folder: folder, finishedToReview: $finishedToReview, learnedCardsCount: $learnedCardsCount)) {
                            Label("Learn", systemImage: "play")
                        }
                    }
                    Button("Delete", systemImage: "trash") {
                        showCourseAlert.toggle()
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
                    Button("Edit", systemImage: "gearshape") {
                        showCourseEdit.toggle()
                    }
                }
            )
        }
        .scrollDisabled(true)
        .onDisappear {
            learnedCardsCount = 0
        }
        .sheet(isPresented: $showCardCreate) {
            CardCreate(folder: folder)
                .presentationDetents([.fraction(0.50)])
        }
        .sheet(isPresented: $showCourseEdit) {
            CourseEdit(folder: folder)
                .presentationDetents([.fraction(0.45)])
        }
    }
}
