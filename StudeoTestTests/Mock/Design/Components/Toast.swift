//
//  Toast.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import Foundation
@testable import StudeoTest

extension Toast.Configuration: Equatable {

  public static func == (lhs: StudeoTest.Toast.Configuration, rhs: StudeoTest.Toast.Configuration) -> Bool {
    switch (lhs, rhs) {
    case (.error(let error1), error(let error2)):
      return (error1 as NSError).code == (error2 as NSError).code
    }
  }
}
