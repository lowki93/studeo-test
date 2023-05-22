//
//  Article.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock
@testable import StudeoTest

extension News: MockUsable {

  public static var anyValue: MockUsable {
    return TestObjectFactory.createArticle()
  }

  public func equal(to value: MockUsable?) -> Bool {
    guard let value = value as? News else { return false }
    return self == value
  }
}
