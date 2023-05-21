//
//  HStack.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

extension HStack {

  init(alignment: VerticalAlignment = .center, spacing: Spacing, @ViewBuilder content: () -> Content) {
    self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
  }
}

