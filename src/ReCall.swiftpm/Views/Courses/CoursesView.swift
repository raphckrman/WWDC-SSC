//
//  CoursesView.swift
//  ReCall
//
//  Created by Raphaël on 23/12/2024.
//

import SwiftUI

func triggerTestNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Ready for studying?"
    content.body = "Your Math Exam is in 3 days! Time to review, you've got this! 💪"
    content.sound = UNNotificationSound.defaultCritical
    content.interruptionLevel = UNNotificationInterruptionLevel.critical

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let request = UNNotificationRequest(identifier: "UpcomingExamTest_\(CGFloat.random(in: 1..<100))", content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error adding notification: \(error.localizedDescription)")
        } else {
            print("Test exam notification scheduled successfully.")
        }
    }
}


struct CoursesView: View {
    var body: some View {
        BaseView(title: "Courses") {
            Button(action: {
                triggerTestNotification()
            }) {
                Text("Trigger Upcoming Exams")
            }
        }
    }
}
