//
//  NotificationsView.swift
//  ReCall
//
//  Created by Raphaël on 26/12/2024.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notificationEnabled = false
    @State private var notificationPermissionGranted = false
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        BaseView(title: "Notifications") {
            List {
                if notificationPermissionGranted {
                    EnableNotificatonsSection(notificationEnabled: $notificationEnabled, notificationPermissionGranted: notificationPermissionGranted)
                    SpecificNotificationsSection()
                        .disabled(!notificationEnabled)
                        .animation(.linear(duration: 0.1), value: notificationEnabled)
                } else {
                    OpenSettingsSection()
                }
            }
            .frame(height: 300)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
            .onAppear {
                Task {
                    notificationEnabled = UserDefaults.standard.value(forKey: "notificationsEnabled") as! Bool? ?? false
                    notificationPermissionGranted = await notificationManager.isNotificationPermissionGranted()
                    print("[DEBUG] Task Executed")
                    print(UserDefaults.standard.value(forKey: "notificationsEnabled") as! Bool? ?? false)
                }
            }
        }
    }
}
