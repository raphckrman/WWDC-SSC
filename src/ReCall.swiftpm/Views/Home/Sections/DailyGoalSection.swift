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
    @State private var DailyGoal: Int = 0
        
    var body: some View {
        sectionTitle("Daily Goal") {
            HStack {
                Spacer()
                CircularProgressMaskedView(height: height, goal: CGFloat(DailyGoal*60), progression: 0)
                    .padding()
                    .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 0)
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    RoundedButton(title: "Start Studying", width: height)
                    RoundedButton(title: "Add Reminder", width: height, primary: false)
                }
                Spacer()
            }
            .offset(y: -height / 2)
        }
        .onAppear {
            DailyGoal = UserDefaults.standard.integer(forKey: "dailyGoal")
        }
    }
}
