import Foundation

class NewsManager: ObservableObject {
    @Published var articles = [Article]()
    @Published var isRefreshing = false // Add isRefreshing property

    let apiKey = "39c44e4f7fb44e87aee3969142328c30"
    let baseUrl = "https://newsapi.org/v2/"

    func fetchNews(for category: String = "general") {
        isRefreshing = true // Set isRefreshing to true when fetching news
        let urlString = "\(baseUrl)top-headlines?country=us&category=\(category)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer { self.isRefreshing = false } // Set isRefreshing to false when finished fetching news
            if let data = data {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles.filter { $0.content != nil && !$0.content!.contains("removed") }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func searchNews(query: String) {
        isRefreshing = true // Set isRefreshing to true when searching news
        let urlString = "\(baseUrl)everything?q=\(query)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer { self.isRefreshing = false } // Set isRefreshing to false when finished searching news
            if let data = data {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles.filter { $0.content != nil && !$0.content!.contains("removed") }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func fetchBusinessNews() {
        isRefreshing = true
        let urlString = "\(baseUrl)top-headlines?country=us&category=business&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer { self.isRefreshing = false }
            if let data = data {
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles.filter { $0.content != nil && !$0.content!.contains("removed") }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
