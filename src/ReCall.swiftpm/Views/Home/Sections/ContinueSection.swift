//
//  ContinueSection.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct ContinueSection: View {
    var folders: [FolderItem]
    
    var body: some View {
        sectionTitle("Continue") {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    Spacer()
                    if folders.isEmpty {
                        MissingRecentCourse()
                        TipsCard(sentence: "Frequent, short sessions are more effective than long cram sessions.")
                        TipsCard(sentence: "Study anytime, even without internet. This app works entirely offline.")
                        TipsCard(sentence: "Work for 25 minutes, then take a 5-minute break to stay focused and productive.")
                    } else {
                        // TODO: Add Recent Course Card
                    }
                    Spacer()
                }
            }
        }
    }
}
