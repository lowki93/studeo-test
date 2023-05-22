//
//  SearchGNewsNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct SearchGNewsNetworkPayload: Decodable, ModelConvertible {

  let articles: [ArticleGNewsNetworkPayload]

  func toModel() throws -> [Article] {
    return try articles.toDomainModel(.dropFailingElements)
  }
}
