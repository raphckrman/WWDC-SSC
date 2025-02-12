//
//  SettingsView.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var toggle = false
    @State private var actualDailyGoal: Int = 0
    @State private var showModal = false
    
    @AppStorage("hapticsEnabled") private var hapticsEnabled: Bool = true
    @AppStorage("studyStreakEnabled") private var studyStreakEnabled: Bool = true
    @AppStorage("studyHoursTrackEnabled") private var studyHoursTrackEnabled: Bool = true
    @AppStorage("progressOverviewEnabled") private var progressOverviewEnabled: Bool = true

    var body: some View {
        BaseView(title: "Settings") {
            List {
                Section(header: Text("General").offset(x: -15)) {
                    RowSettingsNavigation(title: "Notifications", icon: "bell.fill", color: Color.accentColor, destination: AnyView(NotificationsView()))
                    RowSettingsButton(title: "Daily Goal", icon: "target", color: Color.accentColor, action: {
                        showModal.toggle()
                    })
                }
                Section(header: Text("Resources").offset(x: -15)) {
                    RowSettingsNavigation(title: "Tutorial", icon: "sparkles.tv.fill", color: Color.accentColor, destination: AnyView(BlankView()))
                    RowSettingsNavigation(title: "Acknowledgments", icon: "person.2.fill", color: Color.accentColor, destination: AnyView(BlankView()))
                    RowSettingsNavigation(title: "GitHub Repository", icon: "curlybraces.square.fill", color: Color.accentColor, destination: AnyView(BlankView()), url: "https://github.com/raphckrman/WWDC-SSC")
                }
            }
            .frame(height: 600)
            .background(.clear)
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $showModal) {
                DailyGoalPicker()
                    .presentationDetents([.fraction(0.3)])
            }
        }
        .onAppear {
            actualDailyGoal = UserDefaults.standard.integer(forKey: "dailyGoal")
        }
    }
}
