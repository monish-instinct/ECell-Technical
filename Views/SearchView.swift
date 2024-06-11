import SwiftUI

struct SearchView: View {
    @ObservedObject var newsManager = NewsManager()
    @State private var query: String = ""
    @State private var searchHistory: [String] = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []

    func addToHistory(query: String) {
        var currentHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
        currentHistory.append(query)
        UserDefaults.standard.set(currentHistory, forKey: "SearchHistory")
        searchHistory = currentHistory
    }

    var body: some View {
        VStack {
            TextField("Search", text: $query, onCommit: {
                newsManager.searchNews(query: query)
                addToHistory(query: query)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            List(newsManager.articles) { article in
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.headline)
                    Text("By \(article.author ?? "Unknown")")
                        .font(.subheadline)
                    Text(article.publishedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            if !searchHistory.isEmpty {
                VStack(alignment: .leading) {
                    Text("Search History")
                        .font(.headline)
                        .padding(.leading)
                    
                    List(searchHistory, id: \.self) { historyItem in
                        Text(historyItem)
                            .onTapGesture {
                                query = historyItem
                                newsManager.searchNews(query: query)
                            }
                    }
                }
            }
        }
        .navigationTitle("Search News")
    }
}
