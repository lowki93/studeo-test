//
//  ArticleNewsApiNetworkpayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct ArticleNewsApiNetworkpayload: Decodable, ModelConvertible {

  struct SourceNewsApiNetworkpayload: Decodable {
    let id: String?
    let name: String
  }

  let source: SourceNewsApiNetworkpayload
  let author: String?
  let title: String
  let description: String
  let url: URL
  let urlToImage: URL?
  let publishedAt: Date

  func toModel() throws -> News {
    return News(
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
