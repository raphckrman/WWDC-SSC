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
                } toolbarContent: {
                    AnyView(
                        HStack {
                            Button("", systemImage: "plus.circle") {
                                print("ok")
                            }                        }
                    )
                }
                sectionTitle(title: "Improvements") {
                }
                sectionTitle(title: "Badges") {
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } toolbarContent: {
            AnyView(
                HStack {
                    Button("Bookmark", systemImage: folder.favorite ? "bookmark.fill" : "bookmark") {
                        folder.favorite = !folder.favorite
                        try? context.save()
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
