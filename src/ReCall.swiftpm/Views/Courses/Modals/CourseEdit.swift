//
//  CourseEdit.swift
//  ReCall
//
//  Created by Raphaël on 04/01/2025.
//

import SwiftUI

@available(iOS 17, *)
struct CourseEdit: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    var folder: FolderItem
    
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
            .navigationTitle("Edit \(folder.name)")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background(.clear)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        folder.name = courseName
                        folder.subject = selectedCategory.rawValue
                        folder.examDate = hasExam ? examDate : nil
                        try? context.save()
                        feedback()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.all, -5)
        }
        .onAppear {
            courseName = folder.name
            selectedCategory = CourseCategory(rawValue: folder.subject) ?? .general
            examDate = folder.examDate ?? Date()
            hasExam = folder.examDate != nil
        }
    }
}
