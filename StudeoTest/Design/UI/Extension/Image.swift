//
//  Image.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

extension Image {

  init(_ symbol: Symbol) {
    self.init(systemName: symbol.rawValue)
  }
}
