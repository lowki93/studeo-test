//
//  ArticleUpdate.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 23/05/2023.
//

import InstantMock
@testable import StudeoTest

extension ArticleUpdate: MockUsable {

  public static var anyValue: MockUsable {
    return TestObjectFactory.createArticleUpdate()
  }

  public func equal(to value: MockUsable?) -> Bool {
    guard let value = value as? ArticleUpdate else { return false }
    return self == value
  }
}
