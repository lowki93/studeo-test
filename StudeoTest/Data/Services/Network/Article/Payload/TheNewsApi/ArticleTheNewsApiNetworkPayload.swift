//
//  ArticleTheNewsApiNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct ArticleTheNewsApiNetworkPayload: Decodable, ModelConvertible {

  let title: String
  let description: String
  let url: URL
  let imageUrl: URL?
  @DateFormat<Iso8601Full> var publishedAt: Date
  let source: String

  func toModel() throws -> Article {
    return Article(
      id: UUID(),
      title: title,
      image: imageUrl,
      description: description,
      link: url,
      publishedAt: publishedAt,
      source: source
    )
  }
}
