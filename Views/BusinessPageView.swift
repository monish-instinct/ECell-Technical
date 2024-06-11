import SwiftUI

struct BusinessPageView: View {
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
                newsManager.fetchNews(for: "business")
            }
            .navigationTitle("Business News")
            .refreshable {
                newsManager.fetchNews(for: "business")
            }
        }
    }
}
