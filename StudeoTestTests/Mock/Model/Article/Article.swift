//
//  Article.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

extension Article: MockUsable {

  public static var anyValue: MockUsable {
    return TestObjectFactory.createArticle()
  }

  public func equal(to value: MockUsable?) -> Bool {
    guard let value = value as? Article else { return false }
    return self == value
  }
}
