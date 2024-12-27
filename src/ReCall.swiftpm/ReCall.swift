import SwiftUI
import SwiftData

@main
@available(iOS 17, *)
struct ReCall: App {
    @StateObject private var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        await notificationManager.requestNotificationPermission()
                    }
                }
        }
        .modelContainer(for: FolderItem.self)
    }
}
