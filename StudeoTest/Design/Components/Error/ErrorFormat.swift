//
//  ErrorFormat.swift
//  StudeoTest
//
//  Created by Kevin Budain on 22/05/2023.
//

import Foundation

enum ErrorFormat {

  static func localized(from error: Error) -> String {
    switch error {
    case NetworkError.unauthorized:
      return L10n.Error.Network.unauthorized
    case NetworkError.custom(_, let message):
      return message
    default:
      return L10n.Error.unknown
    }
  }
}
