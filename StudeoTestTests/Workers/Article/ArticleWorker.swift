//
//  ArticleWorker.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import XCTest
import InstantMock
@testable import StudeoTest

final class ArticleWorkerTests: XCTestCase {

  private var worker: ArticleWorker!
  private var delegate: ArticleWorkerDelegateMock!
  private var articleNetworkService: ArticleNetworkServiceMock!

  override func setUp() {
    delegate = ArticleWorkerDelegateMock()
    articleNetworkService = ArticleNetworkServiceMock()
    worker = DefaultArticleWorker(newsNetworkService: articleNetworkService)
    worker.delegate = delegate
  }

  func test_news_ok() async throws {
    let expectedQuery = TestObjectFactory.createRandomString()
    let expectedPerPage = TestObjectFactory.createRandomInt()
    let expectedNewsApiArticles = [TestObjectFactory.createArticle()]
    let expectedGnewsArticles = [TestObjectFactory.createArticle()]
    let expectedMediastackApiArticles = [TestObjectFactory.createArticle()]

    try await articleNetworkService
      .expect()
      .call(articleNetworkService.news(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
    /// We can use a captor for the `source`. We should add  an expect for each source
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.news(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedNewsApiArticles)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.news(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedGnewsArticles)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.news(from: Arg.eq(ArticleSource.mediastack), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedMediastackApiArticles)
    await delegate
      .expect()
      .call(delegate.didUpdateNews(Arg.any()), count: 3)

    let results = try await worker.news(query: expectedQuery, perPage: expectedPerPage)

    articleNetworkService.verify()
    delegate.verify()

    XCTAssertEqual(results.count, 3)
    XCTAssertTrue(results.contains(expectedNewsApiArticles))
    XCTAssertTrue(results.contains(expectedGnewsArticles))
    XCTAssertTrue(results.contains(expectedMediastackApiArticles))
  }

}
