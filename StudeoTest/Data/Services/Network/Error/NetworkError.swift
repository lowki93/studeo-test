//
//  NetworkError.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

import Foundation

enum NetworkError: Error, Equatable {
  case unauthorized
  case code(Int)
  case custom(code: Int, message: String)

  var code: Int {
    switch self {
    case .unauthorized:
      return 401
    case .code(let code):
      return code
    case let .custom(code, _):
      return code
    }
  }
}
