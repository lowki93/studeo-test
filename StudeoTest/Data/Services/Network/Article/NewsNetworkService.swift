//
//  ArticleNetworkService.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

protocol ArticleNetworkService {
  func articles(from source: ArticleSource, query: String, perPage: Int) async throws -> [Article]
}
