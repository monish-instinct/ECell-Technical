import SwiftUI

struct TechnologyPageView: View {
    @StateObject var newsManager = NewsManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(newsManager.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            NewsCardView(article: article)
                                .padding(.horizontal)
                        }}}
                .padding(.top)
            }
            .onAppear {
                newsManager.fetchNews(for: "technology")
            }
            .navigationTitle("Technology News")
            .refreshable {
                newsManager.fetchNews(for: "technology")
            }
        }
    }
}
