//
//  NewsRow.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

struct NewsRow: View {

  @Environment(\.redactionReasons) var test
  var news: News

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("At \(Text(news.publishedAt, style: .time)) from \(news.source)")
      }
      .font(.caption2)
      .foregroundColor(.secondary)
      HStack(alignment: .top) {
        Group {
          if let image = news.image, test != .placeholder {
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
            Image(.photoCircle)
              .resizable()
              .foregroundColor(.primary)
              .frame(.ultra)
              .clipShape(Circle())
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
