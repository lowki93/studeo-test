//
//  ArticleNetworkService.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

final class ArticleNetworkServiceMock: Mock, NewsNetworkService {

  func news(from source: NewsSource, query: String, perPage: Int) async throws -> [News] {
    return try super.callThrowing(source, query, perPage)!
  }

}
