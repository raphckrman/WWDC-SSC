//
//  CourseCreate.swift
//  ReCall
//
//  Created by Raphaël on 28/12/2024.
//

import SwiftUI

public enum CourseCategory: String, CaseIterable {
    case general = "General"
    case mathematics = "Mathematics"
    case science = "Science"
    case language = "Language"
    case history = "History"
}

@available(iOS 17, *)
struct CourseCreate: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    @State private var courseName: String = ""
    @State private var selectedCategory: CourseCategory = .general
    @State private var examDate: Date = Date()
    @State private var hasExam: Bool = false


    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Course Information")) {
                    TextField("Name", text: $courseName)
                        .textFieldStyle(.plain)
                    Picker("Subject", selection: $selectedCategory) {
                        ForEach(CourseCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    Toggle("Has Exam", isOn: $hasExam)
                    if hasExam {
                        DatePicker(
                            "Exam Date",
                            selection: $examDate,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                    }
                }
            }
            .navigationTitle("Create a course")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background(.clear)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        let newFolder = FolderItem(name: courseName, subject: selectedCategory.rawValue, examDate: hasExam ? examDate : nil)
                        context.insert(newFolder)
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.subheadline)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.all, -5)
        }
    }
}
