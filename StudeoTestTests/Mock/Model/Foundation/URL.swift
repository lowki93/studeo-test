//
//  URL.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import Foundation
import InstantMock
@testable import StudeoTest

extension URL: MockUsable {

  public static var anyValue: MockUsable {
    return TestObjectFactory.createURL()
  }

  public func equal(to value: MockUsable?) -> Bool {
    guard let value = value as? URL else { return false }
    return self == value
  }
}
