//
//  DailyGoalSection.swift
//  ReCall
//
//  Created by Raphaël on 24/12/2024.
//

import SwiftUI

@available(iOS 17, *)
struct DailyGoalSection: View {
    var folders: [FolderItem]
    var height: CGFloat {
            UIDevice.current.userInterfaceIdiom == .pad ? 450 : 300
        }
        
    var body: some View {
        sectionTitle("Daily Goal") {
            HStack {
                Spacer()
                CircularProgressMaskedView(height: height, goal: 3600, progression: 1132)
                    .padding()
                    .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 0)
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    RoundedButton(title: "Start Studying", width: 300)
                    RoundedButton(title: "Add Reminder", width: 300, primary: false)
                }
                Spacer()
            }
            .offset(y: -height / 2)
        }
    }
}
