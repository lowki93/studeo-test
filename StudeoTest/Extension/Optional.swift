//
//  Optional.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import Foundation

extension String? {

  public var orEmpty: String {
    switch self {
    case .none:
      return ""
    case .some(let wrapped):
      return wrapped
    }
  }
}
