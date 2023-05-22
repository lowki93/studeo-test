//
//  NewsViewModel.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

final class NewsViewModel: ObservableObject, ViewLifeCycle {

  @Published var error: Toast.Configuration?
  @Published var articles : [Article] = Article.placeholders
  var isLoading: Bool {
    return articles == Article.placeholders
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
      self.articles = news
    } catch {
      if isLoading {
        articles = []
      }
      self.error = .error(error)
    }
  }

  func didTapOnNews(article: Article) {
    router.routeToNewDetails(link: article.link)
  }
}

extension NewsViewModel: NewsWorkerDelegate {

  @MainActor
  func didUpdateNews(_ news: [Article]) async {
    self.articles = news
  }
}
