//
//  DecoderService.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

protocol DecoderService {
  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
