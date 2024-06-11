import SwiftUI

struct HomePageView: View {
    @StateObject var newsManager = NewsManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(newsManager.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            NewsCardView(article: article)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .onAppear {
                newsManager.fetchNews(for: "general")
            }
            .navigationTitle("Latest News")
            .refreshable {
                newsManager.fetchNews(for: "general")
            }
        }
    }
}
