//
//  SceneDelegate.swift
//  StudeoTest
//
//  Created by Kevin Budain on 17/05/2023.
//

import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var navigationController: UINavigationController?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene,
          let controller = container.resolve(CustomHostingController<ArticlesView>.self)
    else { return }

    window = UIWindow(windowScene: windowScene)
    navigationController = UINavigationController(rootViewController: controller)
    navigationController?.navigationBar.prefersLargeTitles = true
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) { }

  func sceneDidBecomeActive(_ scene: UIScene) { }

  func sceneWillResignActive(_ scene: UIScene) { }

  func sceneWillEnterForeground(_ scene: UIScene) { }

  func sceneDidEnterBackground(_ scene: UIScene) { }
}

