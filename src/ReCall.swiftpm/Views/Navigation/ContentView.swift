import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab).tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            CoursesView().tabItem {
                Label("Courses", systemImage: "book.fill")
            }
            .tag(1)
            BlankView().tabItem {
                Label("Stats", systemImage: "chart.bar.fill")
            }
            .tag(2)
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(3)
        }
        .tint(Color.accentColor)
        .background(.clear)
        .onChange(of: selectedTab) {
            print("change \(selectedTab)")
        }
    }
}


struct BlankView: View {
    var body: some View {
        BaseView(title: "Blank") {

            }
    }
}
