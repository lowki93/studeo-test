//
//  ArticleGNewsNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct ArticleGNewsNetworkPayload: Decodable, ModelConvertible {

  struct Source: Decodable {
    let name: String
  }

  let source: Source
  let title: String
  let description: String
  let url: URL
  let image: URL?
  @DateFormat<Iso8601> var publishedAt: Date

  func toModel() throws -> Article {
    return Article(
      id: UUID(),
      title: title,
      image: image,
      description: description,
      link: url,
      publishedAt: publishedAt,
      source: source.name
    )
  }
}
