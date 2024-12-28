//
//  UpcomingExamsSection.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct UpcomingExamsSection: View {
    var folders: [FolderItem]
    @Binding var selectedTab: Int
    
    var body: some View {
        sectionTitle("Upcoming Exams") {
            List {
                Section {
                    if folders.isEmpty || !(folders.contains(where: { $0.examDate != nil })) {
                        MissingUpcomingExam(action: {
                            selectedTab = 1
                        })
                    } else {
                        ForEach(folders, id: \.id) { folder in
                            if folder.examDate != nil {
                                UpcomingExamCard(folder: folder)
                            }
                        }
                    }
                } header: {
                    Spacer(minLength: 0).listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                }
            }
            .onAppear {
                print(!(folders.contains(where: { $0.examDate != nil})))
            }
            .frame(height: folders.isEmpty || !(folders.contains(where: { $0.examDate != nil })) ? 113 : CGFloat(folders.filter { $0.examDate != nil }.count) * 107)
            .background(.clear)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
        }
    }
}
