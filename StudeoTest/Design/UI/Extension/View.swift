//
//  View.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

extension View {

  func frame(_ frame: Frame?, alignment: Alignment = .center) -> some View {
    self.frame(width: frame?.rawValue, height: frame?.rawValue, alignment: alignment)
  }

  func padding(_ length: Margin) -> some View {
    padding(.all, length.rawValue)
  }

  func toast(configuration: Binding<Toast.Configuration?>, onDismiss: (() -> Void)? = nil) -> some View {
    ZStack {
      self

      if let value = configuration.wrappedValue {
        Toast(configuration: value, onDismiss: onDismiss)
          .transition(.move(edge: .top).combined(with: .opacity))
          .zIndex(999)
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              configuration.wrappedValue = nil
            }
          }
      }
    }
    .animation(.default.speed(0.5), value: configuration.wrappedValue != nil)
  }

}
