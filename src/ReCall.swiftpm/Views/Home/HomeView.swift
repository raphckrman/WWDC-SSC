//
//  HomeView.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI
import SwiftData

@available(iOS 17, *)
struct HomeView: View {
    @Query(sort: \FolderItem.name) var folders: [FolderItem]
    
    var body: some View {
        BaseView(title: "Home") {
            ContinueSection(folders: folders)
            UpcomingExamsSection(folders: folders)
            DailyGoalSection()
        }
    }
}
