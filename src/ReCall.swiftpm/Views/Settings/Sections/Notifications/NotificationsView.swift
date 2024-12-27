//
//  NotificationsView.swift
//  ReCall
//
//  Created by Raphaël on 26/12/2024.
//

import SwiftUI

struct NotificationsView: View {
    @AppStorage("notificationsEnabled") private var notificationEnabled: Bool = false
    @State private var notificationPermissionGranted = false
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        BaseView(title: "Notifications") {
            List {
                if notificationPermissionGranted {
                    EnableNotificatonsSection(notificationPermissionGranted: notificationPermissionGranted)
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
                    notificationPermissionGranted = await notificationManager.isNotificationPermissionGranted()
                }
            }
        }
    }
}
