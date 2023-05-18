//
//  Container.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Swinject
import Foundation
import SwinjectAutoregistration

extension Container {

  func setup() -> Self {
    registerScenes()

    return self
  }

  private func registerScenes() {
    registerNewsView()
  }

  private func registerNewsView() {
    register(CustomHostingController<NewsView>.self) { _ in
      let viewModel = NewsViewModel()
      let view = NewsView(viewModel: viewModel)
      let viewController = CustomHostingController(rootView: view, viewLifeCycle: viewModel)

      return viewController
    }
  }

}
