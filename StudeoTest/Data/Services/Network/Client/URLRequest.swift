//
//  URLRequest.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Alamofire
import Foundation

public extension URLRequest {

  enum HTTPMethod {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect

    var value: Alamofire.HTTPMethod {
      switch self {
      case .options:
        return .options
      case .get:
        return .get
      case .head:
        return .head
      case .post:
        return .post
      case .put:
        return .put
      case .patch:
        return .patch
      case .delete:
        return .delete
      case .trace:
        return .trace
      case .connect:
        return .connect
      }
    }
  }
}

extension URLRequest.HTTPMethod {

  var rawValue: String {
    switch self {
    case .options:
      return "OPTIONS"
    case .get:
      return "GET"
    case .head:
      return "HEAD"
    case .post:
      return "POST"
    case .put:
      return "PUT"
    case .patch:
      return "PATCH"
    case .delete:
      return "DELETE"
    case .trace:
      return "TRACE"
    case .connect:
      return "CONNECT"
    }
  }
}
