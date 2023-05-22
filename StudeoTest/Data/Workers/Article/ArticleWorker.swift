//
//  ArticleWorker.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

protocol ArticleWorker {
  var delegate: ArticleWorkerDelegate? { get set }
  func news(query: String, perPage: Int) async throws -> [Article]
}

protocol ArticleWorkerDelegate: AnyObject {
  func didUpdateNews(_ articles: [Article]) async
}
