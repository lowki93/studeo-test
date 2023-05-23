//
//  NewsTheNewsApiNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct NewsTheNewsApiNetworkPayload: Decodable, ModelConvertible {

  let data: [ArticleTheNewsApiNetworkPayload]

  func toModel() throws -> [Article] {
    return try data.toDomainModel(.dropFailingElements)
  }
}
