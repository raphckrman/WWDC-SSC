//
//  EnableNotificatonsSection.swift
//  ReCall
//
//  Created by Raphaël on 27/12/2024.
//

import SwiftUI

struct EnableNotificatonsSection: View {
    @Binding var notificationEnabled: Bool
    var notificationPermissionGranted: Bool

    var body: some View {
        Section {
            RowSettingsToggle(title: "Enable Notifications", icon: notificationEnabled ? "bell.fill" : "bell.slash.fill", color: notificationEnabled ? Color.accentColor : Color(UIColor.gray), isOn: $notificationEnabled, disabled: !notificationPermissionGranted)
                .onChange(of: notificationEnabled) { newValue in
                    print("[DEBUG] New Value: \(newValue)")
                    Task {
                        UserDefaults.standard.set(newValue, forKey: "notificationsEnabled")
                    }
                }
                .animation(.linear(duration: 0.1), value: notificationEnabled)
        } header: {
            Spacer(minLength: 0).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
