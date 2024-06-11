import SwiftUI

struct ArticleDetailView: View {
    var article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let urlToImage = article.urlToImage, let imageUrl = URL(string: urlToImage) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("By \(article.author ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(article.publishedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Divider()

                if let content = article.content {
                    if content.contains("[+") {
                        let fullContent = content.replacingOccurrences(of: "[+...]", with: "")
                        Text(fullContent)
                            .font(.body)
                            .lineSpacing(8)
                    } else {
                        Text(content)
                            .font(.body)
                            .lineSpacing(8)
                    }
                } else {
                    Text("No content available")
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle("In-Depth Report")
        .navigationBarTitleDisplayMode(.inline)
    }
}
