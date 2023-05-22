//
//  NewsNetworkService.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

protocol NewsNetworkService {
  func news(from source: NewsSource, query: String, perPage: Int) async throws -> [Article]
}
