//
//  DefaultDecoderService.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct DefaultDecoderService: DecoderService {

  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
//    decoder.dateDecodingStrategy = .formatted(.iso8601Full)//.iso8601
    return decoder
  }()

  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
    return try decoder.decode(type, from: data)
  }
}


extension DateFormatter {

  static var iso8601Full: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    return dateFormatter
  }

  static var iso8601: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    return dateFormatter
  }
}
