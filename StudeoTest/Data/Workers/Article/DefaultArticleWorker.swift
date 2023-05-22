//
//  DefaultArticleWorker.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

final class DefaultArticleWorker: ArticleWorker {

  weak var delegate: ArticleWorkerDelegate? 
  private var articles: [Article] = []
  private let articleNetworkService: any ArticleNetworkService

  init(articleNetworkService: any ArticleNetworkService) {
    self.articleNetworkService = articleNetworkService
  }

  func articles(query: String, perPage: Int) async throws -> [Article] {
    articles.removeAll()
    return try await withThrowingTaskGroup(of: [Article].self) { group in
      for source in ArticleSource.allCases {
        group.addTask {
          do {
            let articles = try await self.articleNetworkService.articles(from: source, query: query, perPage: perPage)
            self.articles += articles
            await self.delegate?.didUpdateNews(self.articles)
            return articles
          } catch {
            throw error
          }
        }
      }

      var articles: [Article] = []
      for try await value in group {
        articles += value
      }
      return articles
    }
  }
}
