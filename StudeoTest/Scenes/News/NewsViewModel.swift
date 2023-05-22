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
  private var articleWorker: any ArticleWorker
  private let router: any NewsRouting

  init(articleWorker: any ArticleWorker, router: any NewsRouting) {
    self.router = router
    self.articleWorker = articleWorker
    self.articleWorker.delegate = self
  }

  @MainActor
  func viewDidLoad() async {
    do {
      let news = try await articleWorker.news(query: "apple", perPage: 2)
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

extension NewsViewModel: ArticleWorkerDelegate {

  @MainActor
  func didUpdateNews(_ news: [Article]) async {
    self.articles = news
  }
}
