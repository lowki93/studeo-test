//
//  Container.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Swinject
import Alamofire
import Foundation
import SwinjectAutoregistration

extension Container {

  func setup() -> Self {
    registerNetworks()
    registerWorkers()
    registerScenes()

    return self
  }

  func registerNetworks() {
    autoregister(Session.self) { Session.default }
    autoregister(NetworkClient.self, initializer: DefaultNetworkClient.init).inObjectScope(.container)
    autoregister(NewsNetworkService.self, initializer: DefaultNewsNetworkService.init)
  }

  func registerWorkers() {
    autoregister(ArticleWorker.self, initializer: DefaultArticleWorker.init)
  }

  private func registerScenes() {
    registerNewsView()
  }

  private func registerNewsView() {
    register(CustomHostingController<NewsView>.self) { resolver in
      let articleWorker = resolver.resolve(ArticleWorker.self)!
      let router = NewsRouter()
      let viewModel = NewsViewModel(articleWorker: articleWorker, router: router)
      let view = NewsView(viewModel: viewModel)
      let viewController = CustomHostingController(rootView: view, viewLifeCycle: viewModel)
      router.inject(viewController: viewController)

      return viewController
    }
  }

}
