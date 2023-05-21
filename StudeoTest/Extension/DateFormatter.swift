//
//  DateFormatter.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import Foundation

extension DateFormatter {

  static func time(style: DateFormatter.Style, date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = style

    return formatter.string(from: date)
  }
}
