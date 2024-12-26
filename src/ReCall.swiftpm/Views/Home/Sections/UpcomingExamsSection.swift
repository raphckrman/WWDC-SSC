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
    
    var body: some View {
        sectionTitle("Upcoming Exams") {
            List {
                Section {
                    MissingUpcomingExam()
                } header: {
                    Spacer(minLength: 0).listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                }
            }
            .frame(height: 113)
            .background(.clear)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
        }
    }
}
