//
//  DefaultArticleWorker.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

final class DefaultArticleWorker: ArticleWorker {

  weak var delegate: ArticleWorkerDelegate?
  private var news: [Article] = []
  private let newsNetworkService: any NewsNetworkService

  init(newsNetworkService: any NewsNetworkService) {
    self.newsNetworkService = newsNetworkService
  }

  func news(query: String, perPage: Int) async throws -> [Article] {
    news.removeAll()
    return try await withThrowingTaskGroup(of: [Article].self) { group in
      for source in ArticleSource.allCases {
        group.addTask {
          do {
            let news = try await self.newsNetworkService.news(from: source, query: query, perPage: perPage)
            self.news += news
            await self.delegate?.didUpdateNews(self.news)
            return news
          } catch {
            throw error
          }
        }
      }

      var news: [Article] = []
      for try await value in group {
        news += value
      }
      return news
    }
  }
}
