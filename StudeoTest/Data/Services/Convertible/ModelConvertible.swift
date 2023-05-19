//
//  ModelConvertible.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

protocol ModelConvertible {
  associatedtype ModelType

  func toModel() throws -> ModelType
}

extension Sequence where Element: ModelConvertible {

  func toDomainModel(_ strategy: ArrayDomainConversionStrategy) throws -> [Element.ModelType] {
    try compactMap { element -> Element.ModelType? in
      do {
        return try element.toModel()
      } catch {
//        DefaultLogService().log(event: .modelConvertible(.failed(elementName: String(describing: type(of: element.self)), error: error)))
        if strategy == .allElements {
          throw error
        }

        return nil
      }
    }
  }
}
