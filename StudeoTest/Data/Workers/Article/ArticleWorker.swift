//
//  ArticleWorker.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

protocol ArticleWorker {
  var delegate: ArticleWorkerDelegate? { get set }
  func articles(query: String, perPage: Int) async throws -> [Article]
}

protocol ArticleWorkerDelegate: AnyObject {
  func didUpdateArticles(_ articles: [Article], type: ArticleUpdate) async
}
