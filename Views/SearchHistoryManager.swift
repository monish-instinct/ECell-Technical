import Foundation
import Combine

class SearchHistoryManager: ObservableObject {
    @Published var searchHistory: [String] {
        didSet {
            UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
        }
    }

    init() {
        self.searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
    }

    func addToHistory(query: String) {
        if !searchHistory.contains(query) {
            searchHistory.append(query)
        }
    }

    func removeFromHistory(at index: Int) {
        searchHistory.remove(at: index)
    }
}
