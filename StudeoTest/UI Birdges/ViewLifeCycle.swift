//
//  ViewLifeCycle.swift
//  Cosmo-Test
//
//  Created by Kevin Budain on 31/03/2023.
//

import Foundation

protocol ViewLifeCycle {
  func viewDidLoad() async
  func viewWillAppear() async
  func viewDidAppear() async
  func viewWillDisappear() async
  func viewDidDisappear() async
}

extension ViewLifeCycle {
  func viewDidLoad() async {}
  func viewWillAppear() async {}
  func viewDidAppear() async {}
  func viewWillDisappear() async {}
  func viewDidDisappear() async {}
}

