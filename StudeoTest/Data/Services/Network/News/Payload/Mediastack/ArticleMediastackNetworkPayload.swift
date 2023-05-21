//
//  ArticleMediastackNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct ArticleMediastackNetworkPayload: Decodable, ModelConvertible {

  let title: String
  let description: String
  let url: URL
  let image: URL?
  let publishedAt: Date
  let source: String

  func toModel() throws -> News {
    return News(
      id: UUID(),
      title: title,
      image: image,
      description: description,
      link: url,
      publishedAt: publishedAt,
      source: source
    )
  }
}
