//
//  ArrayDomainConversionStrategy.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

enum ArrayDomainConversionStrategy {
  /// all elements must be convertible (no throwing)
  case allElements
  /// remove failing converting elements from result
  case dropFailingElements
}
