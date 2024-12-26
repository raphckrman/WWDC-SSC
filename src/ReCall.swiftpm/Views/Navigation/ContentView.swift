import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house.fill")
            }
            CoursesView().tabItem {
                Label("Courses", systemImage: "book.fill")
            }
            BlankView().tabItem {
                Label("Live", systemImage: "flame.fill")
            }
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
        .tint(Color.accentColor)
        .background(.clear)
    }
}


struct BlankView: View {
    var body: some View {
        BaseView(title: "Blank") {

            }
    }
}
