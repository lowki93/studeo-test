//
//  ArticlesRouter.swift
//  StudeoTest
//
//  Created by Kevin Budain on 21/05/2023.
//

import UIKit
import SafariServices

protocol ArticlesRouting {
  func routeToArticleDetails(link: URL)
}

final class ArticlesRouter: ArticlesRouting {

  private weak var viewController: UIViewController?

  func inject(viewController: UIViewController) {
    self.viewController = viewController
  }

  func routeToArticleDetails(link: URL) {
    let controller = SFSafariViewController(url: link)
    controller.modalPresentationStyle = .overFullScreen
    viewController?.present(controller, animated: true)
  }

}
