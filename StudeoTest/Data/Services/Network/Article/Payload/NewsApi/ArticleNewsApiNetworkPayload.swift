//
//  ArticleNewsApiNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct ArticleNewsApiNetworkPayload: Decodable, ModelConvertible {

  struct SourceNewsApiNetworkpayload: Decodable {
    let name: String
  }

  let source: SourceNewsApiNetworkpayload
  let title: String
  let description: String
  let url: URL
  let urlToImage: URL?
  let publishedAt: Date

  func toModel() throws -> Article {
    return Article(
      id: UUID(),
      title: title,
      image: urlToImage,
      description: description,
      link: url,
      publishedAt: publishedAt,
      source: source.name
    )
  }
}
