//
//  EverythingNewsApiNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct EverythingNewsApiNetworkPayload: Decodable, ModelConvertible {

  let articles: [ArticleNewsApiNetworkPayload]

  func toModel() throws -> [News] {
    return try articles.toDomainModel(.dropFailingElements)
  }
}
