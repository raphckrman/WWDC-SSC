//
//  CoursesView.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI
import SwiftData

@available(iOS 17, *)
struct CoursesView: View {
    @Query(sort: \FolderItem.name) var folders: [FolderItem]
    @State private var showCourseCreate = false
    
    var body: some View {
        BaseView(title: "Courses") {

        } toolbarContent: {
            AnyView(
                HStack {
                    Button("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        print("Filtering Courses")
                    }
                    Button("Create", systemImage: "plus.circle") {
                        showCourseCreate.toggle()
                    }
                }
            )
        }
        .sheet(isPresented: $showCourseCreate) {
            CourseCreate()
                .presentationDetents([.fraction(0.4)])

        }
    }
}
