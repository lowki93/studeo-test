//
//  VStack.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

extension VStack {

  init(alignment: HorizontalAlignment = .center, spacing: Spacing, @ViewBuilder content: () -> Content) {
    self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
  }
}

