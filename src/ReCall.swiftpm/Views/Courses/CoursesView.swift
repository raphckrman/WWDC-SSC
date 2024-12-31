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
            if folders.isEmpty {
                ContentUnavailableView("No Courses", systemImage: "note", description: Text("Create your first course !"))
                    .padding(.top, 200)
            } else {
                ScrollView() {
                    VStack(spacing: 10) {
                        ForEach(folders, id: \.id) { folder in
                            ContinueCourseCard(folder: folder)
                                .transition(.move(edge: .trailing))
                                .animation(.easeInOut(duration: 0.3), value: folders)
                        }
                    }
                    .padding(.all, 40)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListHeaderHeight, 0)
                .padding(.all, -40)
            }
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
