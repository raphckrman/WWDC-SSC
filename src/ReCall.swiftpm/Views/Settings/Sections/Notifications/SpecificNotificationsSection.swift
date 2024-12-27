//
//  SpecificNotificationsSection.swift
//  ReCall
//
//  Created by Raphaël on 27/12/2024.
//

import SwiftUI

struct SpecificNotificationsSection: View {
    @State private var reminderNotifications = false
    @State private var dailyGoalNotifications = false
    @State private var studyCycleNotifications = false
    @State private var upcomingExamsNotifications = false

    var body: some View {
        Section {
            RowSettingsToggle(title: "Reminder", icon: "calendar", color: Color.accentColor, isOn: $reminderNotifications, action: { newValue in UserDefaults.standard.set(newValue, forKey: "reminderNotifications") })
            RowSettingsToggle(title: "Daily Goal", icon: "target", color: Color.accentColor, isOn: $dailyGoalNotifications, action: { newValue in UserDefaults.standard.set(newValue, forKey: "dailyGoalNotifications") })
            RowSettingsToggle(title: "Study Cycle", icon: "arrow.trianglehead.counterclockwise", color: Color.accentColor, isOn: $studyCycleNotifications, action: { newValue in UserDefaults.standard.set(newValue, forKey: "studyCycleNotifications") })
            RowSettingsToggle(title: "Upcoming Exams", icon: "clock", color: Color.accentColor, isOn: $upcomingExamsNotifications, action: { newValue in UserDefaults.standard.set(newValue, forKey: "upcomingExamsNotifications") })
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
