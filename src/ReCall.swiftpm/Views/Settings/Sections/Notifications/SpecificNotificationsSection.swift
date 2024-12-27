//
//  SpecificNotificationsSection.swift
//  ReCall
//
//  Created by Raphaël on 27/12/2024.
//

import SwiftUI

struct SpecificNotificationsSection: View {
    @AppStorage("reminderNotifications") private var reminderNotifications: Bool = false
    @AppStorage("dailyGoalNotifications") private var dailyGoalNotifications: Bool = false
    @AppStorage("studyCycleNotifications") private var studyCycleNotifications: Bool = false
    @AppStorage("upcomingExamsNotifications") private var upcomingExamsNotifications: Bool = false

    var body: some View {
        Section {
            RowSettingsToggle(title: "Reminder", icon: "calendar", color: Color.accentColor, isOn: $reminderNotifications)
            RowSettingsToggle(title: "Daily Goal", icon: "target", color: Color.accentColor, isOn: $dailyGoalNotifications)
            RowSettingsToggle(title: "Study Cycle", icon: "arrow.trianglehead.counterclockwise", color: Color.accentColor, isOn: $studyCycleNotifications)
            RowSettingsToggle(title: "Upcoming Exams", icon: "clock", color: Color.accentColor, isOn: $upcomingExamsNotifications)
        }
        .onAppear {
            Task {
                reminderNotifications = UserDefaults.standard.value(forKey: "reminderNotifications") as! Bool? ?? false
                dailyGoalNotifications = UserDefaults.standard.value(forKey: "dailyGoalNotifications") as! Bool? ?? false
                studyCycleNotifications = UserDefaults.standard.value(forKey: "studyCycleNotifications") as! Bool? ?? false
                upcomingExamsNotifications = UserDefaults.standard.value(forKey: "upcomingExamsNotifications") as! Bool? ?? false
            }
        }
    }
}
