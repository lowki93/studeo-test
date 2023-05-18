//
//  CustomHostingController.swift
//  Cosmo-Test
//
//  Created by Kevin Budain on 31/03/2023.
//

import SwiftUI

final class CustomHostingController<T: View>: HostingController<T>, UIGestureRecognizerDelegate {

  var enableSwipeBackGesture: Bool

  init(rootView: T, viewLifeCycle: ViewLifeCycle? = nil, enableSwipeBackGesture: Bool = true) {
    self.enableSwipeBackGesture = enableSwipeBackGesture
    super.init(rootView: rootView, viewLifeCycle: viewLifeCycle)
  }

  @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.interactivePopGestureRecognizer?.isEnabled = enableSwipeBackGesture
  }
}

class HostingController<T: View>: UIHostingController<T> {

  private let viewLifeCycle: ViewLifeCycle?

  init(rootView: T, viewLifeCycle: ViewLifeCycle?) {
    self.viewLifeCycle = viewLifeCycle
    super.init(rootView: rootView)
  }

  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backButtonDisplayMode = .minimal

    Task {
      await viewLifeCycle?.viewDidLoad()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    Task {
      await viewLifeCycle?.viewWillAppear()
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    Task {
      await viewLifeCycle?.viewDidAppear()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    Task {
      await viewLifeCycle?.viewWillDisappear()
    }
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    Task {
      await viewLifeCycle?.viewDidDisappear()
    }
  }
}

