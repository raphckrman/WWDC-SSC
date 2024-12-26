import SwiftUI
import SwiftData

@main
@available(iOS 17, *)
struct ReCall: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FolderItem.self)
    }
}
