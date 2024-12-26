//
//  SettingsView.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        BaseView(title: "Settings") {
            List {
                Section(header: Text("General").offset(x: -15)) {
                    RowSettingsNavigation(title: "Notifications", icon: "bell.fill", color: Color.accentColor, destination: AnyView(BlankView()))
                    RowSettingsNavigation(title: "Vibrations", icon: "waveform.path", color: Color.accentColor, destination: AnyView(BlankView()))
                    RowSettingsNavigation(title: "Daily Goal", icon: "timer", color: Color.accentColor, destination: AnyView(BlankView()))
                }
                Section(header: Text("Stats").offset(x: -15)) {
                    RowSettingsToggle(title: "Study Streak", icon: "flame.fill", color: Color.accentColor)
                    RowSettingsToggle(title: "Study Hours Tracking", icon: "clock.fill", color: Color.accentColor)
                    RowSettingsToggle(title: "Progress Overview", icon: "chart.bar.fill", color: Color.accentColor)
                }
                Section(header: Text("Resources").offset(x: -15)) {
                    RowSettingsNavigation(title: "Tutorial", icon: "sparkles.tv.fill", color: Color.accentColor, destination: AnyView(BlankView()))
                    RowSettingsNavigation(title: "Acknowledgments", icon: "person.2.fill", color: Color.accentColor, destination: AnyView(BlankView()))
                    RowSettingsNavigation(title: "GitHub Repository", icon: "curlybraces.square.fill", color: Color.accentColor, destination: AnyView(BlankView()), url: "https://github.com/raphckrman/WWDC-SSC")
                }
            }
            .frame(height: 800)
            .background(.clear)
            .scrollContentBackground(.hidden)
        }
    }
}
