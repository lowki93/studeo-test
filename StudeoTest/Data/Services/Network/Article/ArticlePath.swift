//
//  ArticlePath.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

enum ArticlePath: NetworkPath {
  case everything
  case search
  case all

  var rawValue: String {
    switch self {
    case .everything:
      return "/everything"
    case .search:
      return "/search"
    case .all:
      return "/news/all"
    }
  }
}
