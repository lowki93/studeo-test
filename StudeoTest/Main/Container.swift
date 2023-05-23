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
    autoregister(ArticleNetworkService.self, initializer: DefaultArticleNetworkService.init)
  }

  func registerWorkers() {
    autoregister(ArticleWorker.self, initializer: DefaultArticleWorker.init)
  }

  private func registerScenes() {
    registerArticlesView()
  }

  private func registerArticlesView() {
    register(CustomHostingController<ArticlesView>.self) { resolver in
      let articleWorker = resolver.resolve(ArticleWorker.self)!
      let router = ArticlesRouter()
      let viewModel = ArticlesViewModel(articleWorker: articleWorker, router: router)
      let view = ArticlesView(viewModel: viewModel)
      let viewController = CustomHostingController(rootView: view, viewLifeCycle: viewModel)
      router.inject(viewController: viewController)

      return viewController
    }
  }

}
