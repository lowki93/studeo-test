//
//  Toast.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import SwiftUI

struct Toast: View {

  enum Configuration {
    case error(Error)
  }

  let configuration: Configuration
  let onDismiss: (() -> Void)?
  private var message: String {
    switch configuration {
    case .error(let error):
      return ErrorFormat.localized(from: error)
    }
  }
  private var icon: Symbol {
    switch configuration {
    case .error:
      return .exclamationmarkTriangleFill
    }
  }
  private var backgroundColor: Color {
    switch configuration {
    case .error:
      return .error
    }
  }

  var body: some View {
    VStack {
      HStack(spacing: .medium) {
        Image(icon)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(.medium)
        Text(message)
          .font(.body)
          .foregroundColor(.primary)
          .multilineTextAlignment(.center)
        Spacer()
      }
      .padding(.medium)
      .frame(maxWidth: .infinity)
      .background(backgroundColor, in: RoundedRectangle(cornerRadius: .medium))
      .padding(.medium)
      Spacer()
    }
    .onDisappear(perform: onDismiss)
  }
}
