//
//  ArticleWorkerDelegateMock.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

final class ArticleWorkerDelegateMock: Mock, ArticleWorkerDelegate {

  func didUpdateArticles(_ articles: [Article], type: ArticleUpdate) {
    super.call(articles, type)
  }
}
