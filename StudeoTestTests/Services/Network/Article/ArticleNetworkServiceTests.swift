//
//  ArticleNetworkServiceTests.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import XCTest
@testable import StudeoTest

final class ArticleNetworkServiceTests: XCTestCase {

  private var service: ArticleNetworkService!

  override func setUp() {
    super.setUp()
    service = DefaultArticleNetworkService(client: createNetworkClient())
  }

  override func tearDown() {
    removeAllStubs()
    super.tearDown()
  }

  func test_articles_ok_newsApi() async throws {
    let source: ArticleSource = .newsApi
    let query = TestObjectFactory.createRandomString()
    let perPage = TestObjectFactory.createRandomInt()
    setupStub(forFile: "newsApi-200", statusCode: 200)

    let articles = try await service.articles(from: source, query: query, perPage: perPage)

    XCTAssertEqual(articles.count, 1)

    let article = articles[0]
    XCTAssertEqual(article.title, "title")
    XCTAssertEqual(article.image, URL(stringLiteral: "https://google.com/image.png"))
    XCTAssertEqual(article.description, "description")
    XCTAssertEqual(article.link, URL(stringLiteral: "https://google.com"))
    XCTAssertEqual(article.publishedAt.description, "2023-05-21 11:00:00 +0000")
    XCTAssertEqual(article.source, "source-name")
  }

  func test_articles_ko_401_newsApi() async throws {
    let source: ArticleSource = .newsApi
    let query = TestObjectFactory.createRandomString()
    let perPage = TestObjectFactory.createRandomInt()
    setupStub(forFile: "error-401", statusCode: 401)

    await XCTAssertAsyncThrowsError(try await service.articles(from: source, query: query, perPage: perPage)) { error in
      XCTAssertEqual(error as! NetworkError, .unauthorized)
    }
  }

  func test_articles_ok_garticles() async throws {
    let source: ArticleSource = .gnews
    let query = TestObjectFactory.createRandomString()
    let perPage = TestObjectFactory.createRandomInt()
    setupStub(forFile: "gnews-200", statusCode: 200)

    let articles = try await service.articles(from: source, query: query, perPage: perPage)

    XCTAssertEqual(articles.count, 1)

    let article = articles[0]
    XCTAssertEqual(article.title, "title")
    XCTAssertEqual(article.image, URL(stringLiteral: "https://google.com/image.png"))
    XCTAssertEqual(article.description, "description")
    XCTAssertEqual(article.link, URL(stringLiteral: "https://google.com"))
    XCTAssertEqual(article.publishedAt.description, "2023-05-21 11:00:00 +0000")
    XCTAssertEqual(article.source, "source-name")
  }

  func test_articles_ko_401_garticles() async throws {
    let source: ArticleSource = .gnews
    let query = TestObjectFactory.createRandomString()
    let perPage = TestObjectFactory.createRandomInt()
    setupStub(forFile: "error-401", statusCode: 401)

    await XCTAssertAsyncThrowsError(try await service.articles(from: source, query: query, perPage: perPage)) { error in
      XCTAssertEqual(error as! NetworkError, .unauthorized)
    }
  }

  func test_articles_ok_theNewsApi() async throws {
    let source: ArticleSource = .theNewsApi
    let query = TestObjectFactory.createRandomString()
    let perPage = TestObjectFactory.createRandomInt()
    setupStub(forFile: "theNewsApi-200", statusCode: 200)

    let articles = try await service.articles(from: source, query: query, perPage: perPage)

    XCTAssertEqual(articles.count, 1)

    let article = articles[0]
    XCTAssertEqual(article.title, "title")
    XCTAssertEqual(article.image, URL(stringLiteral: "https://google.com/image.png"))
    XCTAssertEqual(article.description, "description")
    XCTAssertEqual(article.link, URL(stringLiteral: "https://google.com"))
    XCTAssertEqual(article.publishedAt.description, "2023-05-21 11:00:00 +0000")
    XCTAssertEqual(article.source, "source-name")
  }

  func test_articles_ko_401_theNewsApi() async throws {
    let source: ArticleSource = .theNewsApi
    let query = TestObjectFactory.createRandomString()
    let perPage = TestObjectFactory.createRandomInt()
    setupStub(forFile: "error-401", statusCode: 401)

    await XCTAssertAsyncThrowsError(try await service.articles(from: source, query: query, perPage: perPage)) { error in
      XCTAssertEqual(error as! NetworkError, .unauthorized)
    }
  }
}
