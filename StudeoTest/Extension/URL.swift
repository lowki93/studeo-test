//
//  URL.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation
import Require

extension URL {

  init(stringLiteral value: StaticString) {
      self = URL(string: "\(value)").require(hint: "Invalid URL string literal: \(value)")
  }
}
