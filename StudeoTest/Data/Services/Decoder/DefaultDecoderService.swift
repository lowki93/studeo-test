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
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
    return try decoder.decode(type, from: data)
  }
}
