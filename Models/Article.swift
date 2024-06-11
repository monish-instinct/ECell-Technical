import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id = UUID()
    let title: String
    let author: String?
    let publishedAt: String
    let url: String
    let description: String?
    let content: String?
    let urlToImage: String?
}
