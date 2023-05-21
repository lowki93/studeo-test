//
//  NewsRow.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

struct NewsRow: View {

  @Environment(\.redactionReasons) var redactionReasons
  var news: News

  var body: some View {
    VStack(alignment: .leading, spacing: .xSmall) {
      Text(L10n.News.Row.publishedAtFrom(DateFormatter.time(style: .short, date: news.publishedAt), news.source))
      .font(.caption2)
      .foregroundColor(.secondary)
      HStack(alignment: .top, spacing: .xSmall) {
        Group {
          if let image = news.image {
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
        Text(news.title)
          .font(.headline)
          .foregroundColor(.primary)
      }
      Text(news.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
  }
}
