//
//  CategoryView.swift
//  NewsApp
//
//  Created by InstincT on 06/06/24.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var newsManager = NewsManager()
    let category: String

    var body: some View {
        List(newsManager.articles) { article in
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
        .navigationTitle("\(category.capitalized) News")
        .onAppear {
            newsManager.fetchNews(for: category)
        }
    }
}

