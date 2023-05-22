//
//  ArticleSource.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

extension ArticleSource: MockUsable {

  public static var anyValue: MockUsable {
    return TestObjectFactory.createArticleSource()
  }

  public func equal(to value: MockUsable?) -> Bool {
    guard let value = value as? ArticleSource else { return false }
    return self == value
  }
}
