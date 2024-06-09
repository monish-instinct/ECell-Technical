import SwiftUI

struct NewsCardView: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            if let urlToImage = article.urlToImage, let imageUrl = URL(string: urlToImage) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text("By \(article.author ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(article.publishedAt)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.vertical, 5)
    }
}
