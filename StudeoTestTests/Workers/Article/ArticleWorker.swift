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
    worker = DefaultArticleWorker(articleNetworkService: articleNetworkService)
    worker.delegate = delegate
  }

  func test_articles_ok() async throws {
    let perPage = TestObjectFactory.createRandomInt()
    let expectedQuery = TestObjectFactory.createRandomString()
    let expectedPerPage = perPage / ArticleSource.allCases.count
    let expectedNewsApiArticles = [TestObjectFactory.createArticle()]
    let expectedGnewsArticles = [TestObjectFactory.createArticle()]
    let expectedTheNewsApiApiArticles = [TestObjectFactory.createArticle()]

    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
    /// We can use a captor for the `source`. We should add  an expect for each source
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedNewsApiArticles)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedGnewsArticles)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.theNewsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedTheNewsApiApiArticles)
    delegate
      .expect()
      .call(delegate.didUpdateArticles(Arg.any(), type: Arg.any()), count: 3)

    let results = try await worker.articles(query: expectedQuery, perPage: perPage)

    articleNetworkService.verify()
    delegate.verify()

    XCTAssertEqual(results.count, 3)
    XCTAssertTrue(results.contains(expectedNewsApiArticles))
    XCTAssertTrue(results.contains(expectedGnewsArticles))
    XCTAssertTrue(results.contains(expectedTheNewsApiApiArticles))
  }

  func test_articles_ko_newsApi_failed() async throws {
    let perPage = TestObjectFactory.createRandomInt()
    let expectedQuery = TestObjectFactory.createRandomString()
    let expectedPerPage = perPage / ArticleSource.allCases.count
    let expectedError = TestObjectFactory.TestError.dummy
    let expectedGnewsArticles = [TestObjectFactory.createArticle()]
    let expectedTheNewsApiApiArticles = [TestObjectFactory.createArticle()]

    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
    /// We can use a captor for the `source`. We should add  an expect for each source
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andThrow(expectedError)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedGnewsArticles)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.theNewsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedTheNewsApiApiArticles)
    delegate
      .expect()
      .call(delegate.didUpdateArticles(Arg.any(), type: Arg.any()), count: 2)

    await XCTAssertAsyncThrowsError(try await worker.articles(query: expectedQuery, perPage: perPage)) { error in
      XCTAssertEqual(error as! TestObjectFactory.TestError, .dummy)
    }

    articleNetworkService.verify()
    delegate.verify()
  }

  func test_articles_ko_newsApi_and_gnews_failed() async throws {
    let perPage = TestObjectFactory.createRandomInt()
    let expectedQuery = TestObjectFactory.createRandomString()
    let expectedPerPage = perPage / ArticleSource.allCases.count
    let expectedError = TestObjectFactory.TestError.dummy
    let expectedTheNewsApiApiArticles = [TestObjectFactory.createArticle()]

    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
    /// We can use a captor for the `source`. We should add  an expect for each source
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andThrow(expectedError)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andThrow(expectedError)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.theNewsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedTheNewsApiApiArticles)
    delegate
      .expect()
      .call(delegate.didUpdateArticles(Arg.any(), type: Arg.any()), count: 1)

    await XCTAssertAsyncThrowsError(try await worker.articles(query: expectedQuery, perPage: perPage)) { error in
      XCTAssertEqual(error as! TestObjectFactory.TestError, .dummy)
    }

    articleNetworkService.verify()
    delegate.verify()
  }

  func test_articles_ko_newsApi_gnews_mediastack_failed() async throws {
    let perPage = TestObjectFactory.createRandomInt()
    let expectedQuery = TestObjectFactory.createRandomString()
    let expectedPerPage = perPage / ArticleSource.allCases.count
    let expectedError = TestObjectFactory.TestError.dummy

    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
    /// We can use a captor for the `source`. We should add  an expect for each source
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andThrow(expectedError)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andThrow(expectedError)
    try await articleNetworkService
      .expect()
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.theNewsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andThrow(expectedError)
    delegate
      .reject()
      .call(delegate.didUpdateArticles(Arg.any(), type: Arg.any()))

    await XCTAssertAsyncThrowsError(try await worker.articles(query: expectedQuery, perPage: perPage)) { error in
      XCTAssertEqual(error as! TestObjectFactory.TestError, .dummy)
    }

    articleNetworkService.verify()
    delegate.verify()
  }
}
