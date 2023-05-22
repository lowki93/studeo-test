//
//  TestError.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import InstantMock

extension TestObjectFactory.TestError: MockUsable {

  public static var anyValue: MockUsable {
    return TestObjectFactory.TestError.dummy
  }

  public func equal(to value: MockUsable?) -> Bool {
    guard let value = value as? TestObjectFactory.TestError else { return false }
    return self == value
  }
}
