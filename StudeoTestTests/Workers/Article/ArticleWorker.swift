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
    let expectedQuery = TestObjectFactory.createRandomString()
    let expectedPerPage = TestObjectFactory.createRandomInt()
    let expectedNewsApiArticles = [TestObjectFactory.createArticle()]
    let expectedGnewsArticles = [TestObjectFactory.createArticle()]
    let expectedMediastackApiArticles = [TestObjectFactory.createArticle()]

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
      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.mediastack), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
      .andReturn(expectedMediastackApiArticles)
    delegate
      .expect()
      .call(delegate.didUpdateArticles(Arg.any(), type: Arg.any()), count: 3)

    let results = try await worker.articles(query: expectedQuery, perPage: expectedPerPage)

    articleNetworkService.verify()
    delegate.verify()

    XCTAssertEqual(results.count, 3)
    XCTAssertTrue(results.contains(expectedNewsApiArticles))
    XCTAssertTrue(results.contains(expectedGnewsArticles))
    XCTAssertTrue(results.contains(expectedMediastackApiArticles))
  }

//  func test_articles_ko_newsApi_failed() async throws {
//    let expectedQuery = TestObjectFactory.createRandomString()
//    let expectedPerPage = TestObjectFactory.createRandomInt()
//    let expectedError = TestObjectFactory.TestError.dummy
//    let expectedGnewsArticles = [TestObjectFactory.createArticle()]
//    let expectedMediastackApiArticles = [TestObjectFactory.createArticle()]
//
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
//    /// We can use a captor for the `source`. We should add  an expect for each source
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andThrow(expectedError)
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andReturn(expectedGnewsArticles)
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.mediastack), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andReturn(expectedMediastackApiArticles)
//    delegate
//      .expect()
//      .call(delegate.didUpdateArticles(Arg.any()), count: 2)
//
//    await XCTAssertAsyncThrowsError(try await worker.articles(query: expectedQuery, perPage: expectedPerPage)) { error in
//      XCTAssertEqual(error as! TestObjectFactory.TestError, .dummy)
//    }
//
//    articleNetworkService.verify()
//    delegate.verify()
//  }
//
//  func test_articles_ko_newsApi_and_gnews_failed() async throws {
//    let expectedQuery = TestObjectFactory.createRandomString()
//    let expectedPerPage = TestObjectFactory.createRandomInt()
//    let expectedError = TestObjectFactory.TestError.dummy
//    let expectedMediastackApiArticles = [TestObjectFactory.createArticle()]
//
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
//    /// We can use a captor for the `source`. We should add  an expect for each source
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andThrow(expectedError)
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andThrow(expectedError)
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.mediastack), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andReturn(expectedMediastackApiArticles)
//    delegate
//      .expect()
//      .call(delegate.didUpdateArticles(Arg.any()), count: 1)
//
//    await XCTAssertAsyncThrowsError(try await worker.articles(query: expectedQuery, perPage: expectedPerPage)) { error in
//      XCTAssertEqual(error as! TestObjectFactory.TestError, .dummy)
//    }
//
//    articleNetworkService.verify()
//    delegate.verify()
//  }
//
//  func test_articles_ko_newsApi_gnews_mediastack_failed() async throws {
//    let expectedQuery = TestObjectFactory.createRandomString()
//    let expectedPerPage = TestObjectFactory.createRandomInt()
//    let expectedError = TestObjectFactory.TestError.dummy
//
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.any(), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 3)
//    /// We can use a captor for the `source`. We should add  an expect for each source
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.newsApi), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andThrow(expectedError)
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.gnews), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andThrow(expectedError)
//    try await articleNetworkService
//      .expect()
//      .call(articleNetworkService.articles(from: Arg.eq(ArticleSource.mediastack), query: Arg.eq(expectedQuery), perPage: Arg.eq(expectedPerPage)), count: 1)
//      .andThrow(expectedError)
//    delegate
//      .reject()
//      .call(delegate.didUpdateArticles(Arg.any()))
//
//    await XCTAssertAsyncThrowsError(try await worker.articles(query: expectedQuery, perPage: expectedPerPage)) { error in
//      XCTAssertEqual(error as! TestObjectFactory.TestError, .dummy)
//    }
//
//    articleNetworkService.verify()
//    delegate.verify()
//  }
}
