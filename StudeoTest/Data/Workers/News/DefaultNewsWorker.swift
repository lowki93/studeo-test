//
//  DefaultNewsWorker.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct DefaultNewsWorker: NewsWorker {

  weak var delegate: NewsWorkerDelegate?
  private let newsNetworkService: any NewsNetworkService

  init(newsNetworkService: any NewsNetworkService) {
    self.newsNetworkService = newsNetworkService
  }

  func news(query: String, perPage: Int) async throws -> [News] {
    return try await withThrowingTaskGroup(of: [News].self) { group in
      for source in NewsSource.allCases {
        group.addTask {
          do {
            let news = try await self.newsNetworkService.news(from: source, query: query, perPage: perPage)
            self.delegate?.didUpdateNews(news, from: source)
            return news
          } catch {
            throw error
          }
        }
      }

      var news: [News] = []
      for try await value in group {
        news += value
      }

      return news
    }
  }

}
