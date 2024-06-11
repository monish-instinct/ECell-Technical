import Foundation

class NewsManager: ObservableObject {
    @Published var articles = [Article]()
    @Published var isRefreshing = false
    @Published var loading = false // Add loading state

    let apiKey = "39c44e4f7fb44e87aee3969142328c30"
    let baseUrl = "https://newsapi.org/v2/"

    func fetchNews(for category: String = "general") {
        isRefreshing = true
        loading = true // Set loading to true when fetching news
        let urlString = "\(baseUrl)top-headlines?country=us&category=\(category)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer {
                self.isRefreshing = false
                self.loading = false // Set loading to false when finished fetching news
            }
            if let data = data {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles.filter {
                            $0.content != nil && !$0.content!.contains("removed") &&
                            $0.title != "No title" && $0.author != nil
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func searchNews(query: String) {
        isRefreshing = true
        loading = true // Set loading to true when searching news
        let urlString = "\(baseUrl)everything?q=\(query)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer {
                self.isRefreshing = false
                self.loading = false // Set loading to false when finished searching news
            }
            if let data = data {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles.filter {
                            $0.content != nil && !$0.content!.contains("removed") &&
                            $0.title != "No title" && $0.author != nil
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func fetchLatestNews() {
        fetchNews()
    }

    func fetchBusinessNews() {
        fetchNews(for: "business")
    }
}
