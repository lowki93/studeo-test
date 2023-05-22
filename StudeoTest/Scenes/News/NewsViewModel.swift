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
  var isLoading: Bool {
    return news == News.placeholders
  }
  private var newsWorker: any NewsWorker
  private let router: any NewsRouting

  init(newsWorker: any NewsWorker, router: any NewsRouting) {
    self.router = router
    self.newsWorker = newsWorker
    self.newsWorker.delegate = self
  }

  @MainActor
  func viewDidLoad() async {
    do {
      let news = try await newsWorker.news(query: "apple", perPage: 2)
      self.news = news
    } catch {
      if isLoading {
        news = []
      }
      self.error = .error(error)
    }
  }

  func didTapOnNews(news: News) {
    router.routeToNewDetails(link: news.link)
  }
}

extension NewsViewModel: NewsWorkerDelegate {

  @MainActor
  func didUpdateNews(_ news: [News]) async {
    self.news = news
  }
}
