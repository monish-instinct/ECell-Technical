import Foundation

struct Article: Identifiable, Codable {
    var id: UUID { UUID() }
    let title: String
    let author: String?
    let publishedAt: String
    let urlToImage: String?
    let content: String? // Added content property

    private enum CodingKeys: String, CodingKey {
        case title, author, publishedAt, urlToImage, content
    }
}

struct NewsResponse: Codable {
    let articles: [Article]
}
