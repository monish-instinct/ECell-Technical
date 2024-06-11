import SwiftUI

struct ContentView: View {
    @StateObject private var searchHistoryManager = SearchHistoryManager()

    var body: some View {
        TabView {
            HomeView(searchHistoryManager: searchHistoryManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            TechnologyView(searchHistoryManager: searchHistoryManager)
                .tabItem {
                    Image(systemName: "desktopcomputer")
                    Text("Technology")
                }

            BusinessView(searchHistoryManager: searchHistoryManager)
                .tabItem {
                    Image(systemName: "briefcase")
                    Text("Business")
                }
        }
        .accentColor(.blue)
                .transition(.slide)
                .animation(.easeInOut(duration: 0.5))
    }
}
