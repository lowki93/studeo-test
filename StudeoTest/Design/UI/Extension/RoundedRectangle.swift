//
//  RoundedRectangle.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

extension RoundedRectangle {

  init(cornerRadius: CornerRadius, style: RoundedCornerStyle = .circular) {
    self.init(cornerRadius: cornerRadius.rawValue, style: style)
  }
}


