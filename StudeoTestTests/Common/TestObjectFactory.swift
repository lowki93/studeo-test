//
//  TestObjectFactory.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import Foundation
@testable import StudeoTest

enum TestObjectFactory {

  // MARK: - Error
  enum TestError: Error {
    case dummy
  }

  // MARK: - Model
  static func createArticle() -> News {
    return News(
      id: UUID(), title: createRandomString(),
      image: nil,
      description: createRandomString(),
      link: createURL(),
      publishedAt: Date(),
      source: createRandomString()
    )
  }

  static func createArticles() -> [News] {
    return Array(repeating: createArticle(), count: createRandomInt())
  }

  static func createArticleSource() -> NewsSource {
    return [.newsApi, .gnews, .mediastack].randomElement() ?? .newsApi
  }

  // MARK: - Generator
  static func createRandomString(length: Int = 32) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).compactMap { _ in letters.randomElement() })
  }

  static func createRandomInt() -> Int {
    return Int.random(in: 1...100)
  }

  static func createURL() -> URL {
    return URL(string: "https://www.\(createRandomString()).com")!
  }

}
