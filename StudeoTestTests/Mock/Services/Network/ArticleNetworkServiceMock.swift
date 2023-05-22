//
//  ArticleNetworkService.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

final class ArticleNetworkServiceMock: Mock, ArticleNetworkService {

  func articles(from source: ArticleSource, query: String, perPage: Int) async throws -> [Article] {
    return try super.callThrowing(source, query, perPage)!
  }

}
