import SwiftUI

struct SportsView: View {
    @ObservedObject var newsManager = NewsManager()
    @ObservedObject var searchHistoryManager: SearchHistoryManager
    @State private var query: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search sports news...", text: $query, onCommit: {
                    newsManager.searchNews(query: query)
                    searchHistoryManager.addToHistory(query: query)
                })
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemGray6))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                )
                .padding(.horizontal)

                if !searchHistoryManager.searchHistory.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Search History")
                            .font(.headline)
                            .padding(.leading)
                            .padding(.top)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(searchHistoryManager.searchHistory.indices, id: \.self) { index in
                                    HStack {
                                        Button(action: {
                                            query = searchHistoryManager.searchHistory[index]
                                            newsManager.searchNews(query: query)
                                        }) {
                                            Text(searchHistoryManager.searchHistory[index])
                                                .padding(.horizontal)
                                                .padding(.vertical, 5)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(10)
                                        }
                                        Button(action: {
                                            searchHistoryManager.removeFromHistory(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 4)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }

                List(newsManager.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
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
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    newsManager.fetchNews(for: "sports") // Fetch sports news articles
                }
            }
            .navigationTitle("Sports News")
            .onAppear {
                newsManager.fetchNews(for: "sports") // Fetch sports news articles initially
            }
        }
    }
}
