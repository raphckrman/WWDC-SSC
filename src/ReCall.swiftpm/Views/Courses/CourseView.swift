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
