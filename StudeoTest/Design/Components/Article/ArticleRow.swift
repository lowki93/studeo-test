//
//  ArticleRow.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

struct ArticleRow: View {

  @Environment(\.redactionReasons) var redactionReasons
  var article: Article

  var body: some View {
    VStack(alignment: .leading, spacing: .xSmall) {
      Text(L10n.Article.Row.publishedAtFrom(DateFormatter.time(style: .short, date: article.publishedAt), article.source))
      .font(.caption2)
      .foregroundColor(.secondary)
      HStack(alignment: .top, spacing: .xSmall) {
        Group {
          if let image = article.image {
            AsyncImage(url: image) { phase in
              switch phase {
              case .success(let image):
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              case .failure(_), .empty:
                EmptyView()
              @unknown default:
                EmptyView()
              }
            }
          } else {
            if redactionReasons == .placeholder {
              Image(.photoCircle)
                .resizable()
                .foregroundColor(.title)
                .frame(.ultra)
                .clipShape(Circle())
            }
          }
        }
        .clipShape(Circle())
        .frame(.ultra)
        Text(article.title)
          .font(.headline)
          .foregroundColor(.primary)
      }
      Text(article.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
  }
}
