//
//  ArticleWorkerMock.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

final class ArticleWorkerMock: Mock, NewsWorker {

  var delegate: NewsWorkerDelegate?

  func news(query: String, perPage: Int) async throws -> [News] {
    return try super.callThrowing(query, perPage)!
  }
}
