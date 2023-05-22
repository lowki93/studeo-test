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

  private var viewModel: NewsViewModel!
  private var articleWorker: ArticleWorkerMock!
  private var router: ArticlesRoutingMock!

  override func setUp() {
    articleWorker = ArticleWorkerMock()
    router = ArticlesRoutingMock()
    viewModel = NewsViewModel(newsWorker: articleWorker, router: router)
  }

  func test_viewDidLoad_ok() async throws {
    let expectedQuery = "apple"
    let expectedPerPage = 2
    let expectedArticles = TestObjectFactory.createArticles()
    let queryCaptor = ArgumentCaptor<String>()
    let perPageCaptor = ArgumentCaptor<Int>()

    try await articleWorker
      .expect()
      .call(articleWorker.news(query: queryCaptor.capture(), perPage: perPageCaptor.capture()), count: 1)
      .andReturn(expectedArticles)

    await viewModel.viewDidLoad()

    articleWorker.verify()

    XCTAssertEqual(queryCaptor.allValues, [expectedQuery])
    XCTAssertEqual(perPageCaptor.allValues, [expectedPerPage])
    XCTAssertEqual(viewModel.news, expectedArticles)
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
      .call(articleWorker.news(query: queryCaptor.capture(), perPage: perPageCaptor.capture()), count: 1)
      .andThrow(expectedError)

    await viewModel.viewDidLoad()

    articleWorker.verify()

    XCTAssertEqual(queryCaptor.allValues, [expectedQuery])
    XCTAssertEqual(perPageCaptor.allValues, [expectedPerPage])
    XCTAssertEqual(viewModel.news, [])
    XCTAssertEqual(viewModel.error, .error(expectedError))
  }

  func test_viewDidLoad_ko_isLoading_false() async throws {
    let expectedQuery = "apple"
    let expectedPerPage = 2
    let expectedArticles = TestObjectFactory.createArticles()
    let expectedError = TestObjectFactory.TestError.dummy
    let queryCaptor = ArgumentCaptor<String>()
    let perPageCaptor = ArgumentCaptor<Int>()

    viewModel.news = expectedArticles
    try await articleWorker
      .expect()
      .call(articleWorker.news(query: queryCaptor.capture(), perPage: perPageCaptor.capture()), count: 1)
      .andThrow(expectedError)

    await viewModel.viewDidLoad()

    articleWorker.verify()

    XCTAssertEqual(queryCaptor.allValues, [expectedQuery])
    XCTAssertEqual(perPageCaptor.allValues, [expectedPerPage])
    XCTAssertEqual(viewModel.news, expectedArticles)
    XCTAssertEqual(viewModel.error, .error(expectedError))
  }

  func test_didTapOnNews() {
    let expectedArticle = TestObjectFactory.createArticle()
    let linkCaptor = ArgumentCaptor<URL>()

    router
      .expect()
      .call(router.routeToNewDetails(link: linkCaptor.capture()), count: 1)

    viewModel.didTapOnNews(news: expectedArticle)

    router.verify()
  }

  // MARK: - NewsWorkerDelegate
  func test_didUpdateNews_ok() async {
    let expectedArticles = TestObjectFactory.createArticles()

    await articleWorker.delegate?.didUpdateNews(expectedArticles)

    XCTAssertEqual(viewModel.news, expectedArticles)
  }
}
