//
//  DateFormat.swift
//  StudeoTest
//
//  Created by Kevin Budain on 23/05/2023.
//

import Foundation

protocol DecodableTransformer {
  associatedtype Source: Decodable
  associatedtype Object

  static func transform(from decodable: Source) throws -> Object
}

@propertyWrapper
struct DateFormat<T: DecodableTransformer>: Decodable {
  var wrappedValue: T.Object

  init(from decoder: Decoder) throws {
    let source = try T.Source(from: decoder)
    wrappedValue = try T.transform(from: source)
  }
}

enum Iso8601Full: DecodableTransformer {

  static func transform(from decodable: String) throws -> Date {
    guard let date = DateFormatter.iso8601Full.date(from: decodable) else {
      throw DateFormatError.transformFailed
    }

    return date
  }
}

enum Iso8601: DecodableTransformer {

  static func transform(from decodable: String) throws -> Date {
    guard let date = DateFormatter.iso8601.date(from: decodable) else {
      throw DateFormatError.transformFailed
    }

    return date
  }
}
