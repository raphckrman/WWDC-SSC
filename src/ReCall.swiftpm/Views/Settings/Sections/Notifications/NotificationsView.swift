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

    private func openAppSettings() {
        let url = URL(string:UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    var body: some View {
        BaseView(title: "Notifications") {
            List {
                if notificationPermissionGranted {
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
                } else {
                    Section {
                        RowSettingsButton(title: "Open Settings", icon: "gearshape.fill", color: Color(UIColor.gray), action: { openAppSettings() })
                    } header: {
                        Spacer(minLength: 0).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    } footer: {
                        Text("Click the button to open your device's settings and enable notifications.")
                    }
                }
            }
            .frame(height: 200)
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
