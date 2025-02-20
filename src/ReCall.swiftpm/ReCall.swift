import SwiftUI
import SwiftData

@main
@available(iOS 17, *)
struct ReCall: App {
    @StateObject private var notificationManager = NotificationManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    private let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(
                for: FolderItem.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        } catch {
            fatalError("\(error)")
        }
    }
                    
    @AppStorage("notificationsEnabled") var notificationEnabled: Bool = false
    @AppStorage("reminderNotifications") var reminderNotifications: Bool = false
    @AppStorage("dailyGoalNotifications") var dailyGoalNotifications: Bool = false
    @AppStorage("studyCycleNotifications") var studyCycleNotifications: Bool = false
    @AppStorage("upcomingExamsNotifications") var upcomingExamsNotifications: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    AppDelegate.orientationLock = .portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    Task {
                        await notificationManager.requestNotificationPermission()
                    }
                }
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        updateNotifications()
                    }
                }
        }
        .modelContainer(modelContainer)
    }

    private func updateNotifications() {
        DispatchQueue.main.async {
            let context = modelContainer.mainContext
            var folders = [FolderItem]()
            do {
                let descriptor = FetchDescriptor<FolderItem>(
                    sortBy: [SortDescriptor(\.name)]
                )
                folders = try context.fetch(descriptor)
            } catch {
            }
            
            if !notificationEnabled {
                notificationManager.removePendingNotifications()
            }
            if !dailyGoalNotifications {
                notificationManager.removePendingNotificationsForCategory(category: "dailyGoalNotifications")
            } else {
                scheduleDailyGoalNotifications()
            }
            if !studyCycleNotifications {
                notificationManager.removePendingNotificationsForCategory(category: "studyCycleNotifications")
            } else {
                scheduleStudyCycleNotifications(folders: folders)
            }
            if !upcomingExamsNotifications {
                notificationManager.removePendingNotificationsForCategory(category: "upcomingExamsNotifications")
            } else {
                scheduleUpcomingExamsNotifications(folders: folders)
            }
        }
    }
    
    private func scheduleStudyCycleNotifications(folders: [FolderItem]) {
        for folder in folders {
            notificationManager.scheduleNotification(identifier: folder.id.uuidString, title: "Time to study!", body: "Review '\(folder.name)' now! Stay on track! 📚", date: folder.nextReviewDate, category: "studyCycleNotifications")

        }
    }
    
    private func scheduleUpcomingExamsNotifications(folders: [FolderItem]) {
        for folder in folders {
            if let examDate = folder.examDate {
                let calendar = Calendar.current
                
                var notificationTime = calendar.dateComponents([.year, .month, .day], from: examDate)
                notificationTime.hour = 9
                notificationTime.minute = 0

                for daysBefore in [3, 2, 1] {
                    if let notificationDate = calendar.date(byAdding: .day, value: -daysBefore, to: calendar.date(from: notificationTime)!) {
                        notificationManager.scheduleNotification(
                            identifier: "\(folder.id.uuidString)_\(daysBefore)daysBefore",
                            title: "Ready for studying?",
                            body: "Your \(folder.subject) exam is in \(daysBefore) day\(daysBefore > 1 ? "s" : "")! Time to review, you've got this! 📚",
                            date: notificationDate,
                            category: "upcomingExamsNotifications"
                        )
                    }
                }
            }
        }
    }
    
    private func scheduleDailyGoalNotifications() {
        var actualDailyGoal = UserDefaults.standard.integer(forKey: "dailyGoal")
        actualDailyGoal == 0 ? actualDailyGoal = 10 : ()

        let calendar = Calendar.current
        let now = Date()

        var notificationTime = calendar.dateComponents([.year, .month, .day], from: now)
        notificationTime.hour = 12
        notificationTime.minute = 0

        let today = calendar.date(from: notificationTime)!
        let notificationDate = calendar.date(byAdding: .day, value: 1, to: today)!
        
        notificationManager.scheduleNotification(identifier: "dailyGoal", title: "Daily Goal", body: "You set a goal of \(actualDailyGoal) minutes—let’s keep the streak going! 🔥", date: notificationDate, category: "dailyGoalNotifications")
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.all //By default you want all your views to rotate freely

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
