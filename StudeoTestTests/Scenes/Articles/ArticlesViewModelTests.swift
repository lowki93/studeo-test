//
//  ArticlesViewModelTests.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import XCTest
import InstantMock
@testable import StudeoTest

final class ArticlesViewModelTests: XCTestCase {

  private var viewModel: ArticlesViewModel!
  private var articleWorker: ArticleWorkerMock!
  private var router: ArticlesRoutingMock!

  override func setUp() {
    articleWorker = ArticleWorkerMock()
    router = ArticlesRoutingMock()
    viewModel = ArticlesViewModel(articleWorker: articleWorker, router: router)
  }

  func test_viewDidLoad_ok() async throws {
    let expectedQuery = "apple"
    let expectedPerPage = 2
    let expectedArticles = TestObjectFactory.createArticles()
    let queryCaptor = ArgumentCaptor<String>()
    let perPageCaptor = ArgumentCaptor<Int>()

    try await articleWorker
      .expect()
      .call(articleWorker.articles(query: queryCaptor.capture(), perPage: perPageCaptor.capture()), count: 1)
      .andReturn(expectedArticles)

    await viewModel.viewDidLoad()

    articleWorker.verify()

    XCTAssertEqual(queryCaptor.allValues, [expectedQuery])
    XCTAssertEqual(perPageCaptor.allValues, [expectedPerPage])
    XCTAssertEqual(viewModel.articles, expectedArticles)
    XCTAssertNil(viewModel.error)
  }

  func test_viewDidLoad_ko_isLoading_true() async throws {
    let expectedQuery = "apple"
    let expectedPerPage = 2
    let expectedError = TestObjectFactory.TestError.dummy
    let queryCaptor = ArgumentCaptor<String>()
    let perPageCaptor = ArgumentCaptor<Int>()

    try await articleWorker
      .expect()
      .call(articleWorker.articles(query: queryCaptor.capture(), perPage: perPageCaptor.capture()), count: 1)
      .andThrow(expectedError)

    await viewModel.viewDidLoad()

    articleWorker.verify()

    XCTAssertEqual(queryCaptor.allValues, [expectedQuery])
    XCTAssertEqual(perPageCaptor.allValues, [expectedPerPage])
    XCTAssertEqual(viewModel.articles, [])
    XCTAssertEqual(viewModel.error, .error(expectedError))
  }

  func test_viewDidLoad_ko_isLoading_false() async throws {
    let expectedQuery = "apple"
    let expectedPerPage = 2
    let expectedArticles = TestObjectFactory.createArticles()
    let expectedError = TestObjectFactory.TestError.dummy
    let queryCaptor = ArgumentCaptor<String>()
    let perPageCaptor = ArgumentCaptor<Int>()

    viewModel.articles = expectedArticles
    try await articleWorker
      .expect()
      .call(articleWorker.articles(query: queryCaptor.capture(), perPage: perPageCaptor.capture()), count: 1)
      .andThrow(expectedError)

    await viewModel.viewDidLoad()

    articleWorker.verify()

    XCTAssertEqual(queryCaptor.allValues, [expectedQuery])
    XCTAssertEqual(perPageCaptor.allValues, [expectedPerPage])
    XCTAssertEqual(viewModel.articles, expectedArticles)
    XCTAssertEqual(viewModel.error, .error(expectedError))
  }

  func test_didTapOnArticle() {
    let expectedArticle = TestObjectFactory.createArticle()
    let linkCaptor = ArgumentCaptor<URL>()

    router
      .expect()
      .call(router.routeToArticleDetails(link: linkCaptor.capture()), count: 1)

    viewModel.didTapOnArticle(expectedArticle)

    router.verify()
  }

  // MARK: - ArticleWorkerDelegate
  func test_didUpdateNews_ok_reset() async {
    let articles = TestObjectFactory.createArticles()
    let expectedArticles = TestObjectFactory.createArticles()

    viewModel.articles = articles
    await articleWorker.delegate?.didUpdateArticles(expectedArticles, type: .reset)

    XCTAssertEqual(viewModel.articles, expectedArticles)
  }

  func test_didUpdateNews_ok_update() async {
    let articles = TestObjectFactory.createArticles()
    let expectedArticles = TestObjectFactory.createArticles()

    viewModel.articles = articles
    await articleWorker.delegate?.didUpdateArticles(expectedArticles, type: .update)

    XCTAssertEqual(viewModel.articles, articles + expectedArticles)
  }
}
