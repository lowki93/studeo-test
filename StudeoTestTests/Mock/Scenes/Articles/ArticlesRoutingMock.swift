//
//  ArticlesRoutingMock.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import Foundation
import InstantMock
@testable import StudeoTest

final class ArticlesRoutingMock: Mock, NewsRouting {

  func routeToNewDetails(link: URL) {
    super.call(link)
  }
}
