import Foundation

class SearchHistoryManager: ObservableObject {
    @Published var searchHistory: [String] = []

    private let historyKey = "SearchHistory"

    init() {
        loadSearchHistory()
    }

    func addToHistory(query: String) {
        if !query.isEmpty {
            if let index = searchHistory.firstIndex(of: query) {
                searchHistory.remove(at: index)
            }
            searchHistory.insert(query, at: 0)
            saveSearchHistory()
        }
    }

    func removeFromHistory(at index: Int) {
        searchHistory.remove(at: index)
        saveSearchHistory()
    }

    private func saveSearchHistory() {
        UserDefaults.standard.set(searchHistory, forKey: historyKey)
    }

    private func loadSearchHistory() {
        if let history = UserDefaults.standard.array(forKey: historyKey) as? [String] {
            searchHistory = history
        }
    }
}
