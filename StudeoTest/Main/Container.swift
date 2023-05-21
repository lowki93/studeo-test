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
    autoregister(NewsWorker.self, initializer: DefaultNewsWorker.init)
  }

  private func registerScenes() {
    registerNewsView()
  }

  private func registerNewsView() {
    register(CustomHostingController<NewsView>.self) { resolver in
      let newsWorker = resolver.resolve(NewsWorker.self)!
      let viewModel = NewsViewModel(newsWorker: newsWorker)
      let view = NewsView(viewModel: viewModel)
      let viewController = CustomHostingController(rootView: view, viewLifeCycle: viewModel)

      return viewController
    }
  }

}
