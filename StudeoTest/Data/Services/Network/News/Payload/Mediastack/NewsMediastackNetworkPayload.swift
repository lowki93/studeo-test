//
//  NewsMediastackNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct NewsMediastackNetworkPayload: Decodable, ModelConvertible {

  let data: [ArticleMediastackNetworkPayload]

  func toModel() throws -> [Article] {
    return try data.toDomainModel(.dropFailingElements)
  }
}
