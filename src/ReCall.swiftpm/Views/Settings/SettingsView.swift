//
//  SettingsView.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var toggle = false
    @State private var showAlert = false
    @State private var enteredNumber: String = ""
    @State private var actualDailyGoal: Int = 0

    var body: some View {
        BaseView(title: "Settings") {
            List {
                Section(header: Text("General").offset(x: -15)) {
                    RowSettingsNavigation(title: "Notifications", icon: "bell.fill", color: Color.accentColor, destination: AnyView(NotificationsView()))
                    RowSettingsToggle(title: "Vibrations", icon: "waveform.path", color: Color.accentColor, isOn: $toggle)
                    RowSettingsButton(title: "Daily Goal", icon: "target", color: Color.accentColor, action: {
                        showAlert.toggle()
                    })
                }
                Section(header: Text("Stats").offset(x: -15)) {
                    RowSettingsToggle(title: "Study Streak", icon: "flame.fill", color: Color.accentColor, isOn: $toggle)
                    RowSettingsToggle(title: "Study Hours Tracking", icon: "clock.fill", color: Color.accentColor, isOn: $toggle)
                    RowSettingsToggle(title: "Progress Overview", icon: "chart.bar.fill", color: Color.accentColor, isOn: $toggle)
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
            .alert("Enter your daily goal (in minutes)", isPresented: $showAlert) {
                TextField("", text: $enteredNumber)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                
                Button("OK") {
                    if let number = Int(enteredNumber) {
                        UserDefaults.standard.set(number, forKey: "dailyGoal")
                        actualDailyGoal = number
                    }
                }
                
                Button("Cancel", role: .cancel) {
                }
            } message: {
                Text("Veuillez entrer un nombre.")
            }
        }
        .onAppear {
            actualDailyGoal = UserDefaults.standard.integer(forKey: "dailyGoal")
        }
    }
}
