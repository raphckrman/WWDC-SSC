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
        sectionTitle(title: "Upcoming Exams") {
            List {
                Section {
                    if folders.isEmpty || !(folders.contains(where: { $0.examDate != nil })) {
                        MissingUpcomingExam(action: {
                            selectedTab = 1
                        })
                    } else {
                        ForEach(folders.sorted { ($0.examDate ?? Date.distantFuture) < ($1.examDate ?? Date.distantFuture) }, id: \.id) { folder in
                            if folder.examDate != nil {
                                UpcomingExamCard(folder: folder)
                                    .transition(.move(edge: .trailing))
                                    .animation(.easeInOut(duration: 0.3), value: folders)
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
