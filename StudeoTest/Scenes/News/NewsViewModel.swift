//
//  NewsViewModel.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

final class NewsViewModel: ObservableObject, ViewLifeCycle {

  @Published var error: Toast.Configuration?
  @Published var news : [News] = News.placeholders
  private var newsWorker: any NewsWorker

  init(newsWorker: any NewsWorker) {
    self.newsWorker = newsWorker
    self.newsWorker.delegate = self
  }

  @MainActor
  func viewDidLoad() async {
    do {
      let news = try await newsWorker.news(query: "apple", perPage: 2)
      self.news = news
    } catch {
      self.error = .error(error)
    }
  }
}

extension NewsViewModel: NewsWorkerDelegate {

  @MainActor
  func didUpdateNews(_ news: [News]) async {
    self.news = news
  }
}
