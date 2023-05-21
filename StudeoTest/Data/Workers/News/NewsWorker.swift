//
//  NewsWorker.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

protocol NewsWorker {
  var delegate: NewsWorkerDelegate? { get set }
  func news(query: String, perPage: Int) async throws -> [News]
}

protocol NewsWorkerDelegate: AnyObject {
  func didUpdateNews(_ news: [News]) async
}
