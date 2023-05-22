//
//  NewsPath.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

enum NewsPath: NetworkPath {
  case everything
  case search
  case news

  var rawValue: String {
    switch self {
    case .everything:
      return "/everything"
    case .search:
      return "/search"
    case .news:
      return "/news"
    }
  }
}
