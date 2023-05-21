//
//  NewsRouter.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import UIKit
import SafariServices

protocol NewsRouting {
  func routeToNewDetails(link: URL)
}

final class NewsRouter: NewsRouting {

  private weak var viewController: UIViewController?

  func inject(viewController: UIViewController) {
    self.viewController = viewController
  }

  func routeToNewDetails(link: URL) {
    let controller = SFSafariViewController(url: link)
    controller.modalPresentationStyle = .overFullScreen
    viewController?.present(controller, animated: true)
  }

}
