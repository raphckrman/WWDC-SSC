//
//  NotificationManager.swift
//  ReCall
//
//  Created by Raphaël on 26/12/2024.
//

@preconcurrency import UserNotifications

@MainActor
class NotificationManager: ObservableObject {
    
    func requestNotificationPermission() async {
        if let granted = UserDefaults.standard.value(forKey: "notificationsEnabled") as? Bool {
            if granted {
                print("[DEBUG] Notifications are already enabled")
            } else {
                print("[DEBUG] Notifications are already denied")
            }
            return
        }

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: authOptions)
            UserDefaults.standard.set(granted, forKey: "notificationsEnabled")
            UserDefaults.standard.set(granted, forKey: "reminderNotifications")
            UserDefaults.standard.set(granted, forKey: "dailyGoalNotifications")
            UserDefaults.standard.set(granted, forKey: "studyCycleNotifications")
            UserDefaults.standard.set(granted, forKey: "upcomingExamsNotifications")
            if granted {
                print("[DEBUG] Permission Granted")
            } else {
                print("[DEBUG] Permission Not Granted")
            }
        } catch {
            UserDefaults.standard.set(false, forKey: "notificationsEnabled")
            UserDefaults.standard.set(false, forKey: "reminderNotifications")
            UserDefaults.standard.set(false, forKey: "dailyGoalNotifications")
            UserDefaults.standard.set(false, forKey: "studyCycleNotifications")
            UserDefaults.standard.set(false, forKey: "upcomingExamsNotifications")
            print("[DEBUG] Error: \(error.localizedDescription)")
        }
    }
    
    func isNotificationPermissionGranted() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        
        switch settings.authorizationStatus {
        case .authorized, .provisional:
            return true
        case .denied, .notDetermined:
            return false
        case .ephemeral:
            return true
        @unknown default:
            return false
        }
    }
    
    func removePendingNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    
    func removePendingNotificationsForCategory(category: String) {
        let center = UNUserNotificationCenter.current()

        Task {
            let requests = await center.pendingNotificationRequests()
            let categoryNotifications = requests
                .filter { $0.identifier.hasPrefix(category) }
                .map { $0.identifier }

            center.removePendingNotificationRequests(withIdentifiers: categoryNotifications)
        }
    }

    func scheduleNotification(identifier: String, title: String, body: String, date: Date, category: String) {        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.defaultCritical
        content.interruptionLevel = .timeSensitive

        let trigger = UNCalendarNotificationTrigger(
           dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date),
           repeats: false
       )
        
        let request = UNNotificationRequest(identifier: category + "_" + identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

}
