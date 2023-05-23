//
//  ArticlesViewModel.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

final class ArticlesViewModel: ObservableObject, ViewLifeCycle {

  @Published var error: Toast.Configuration?
  @Published var articles : [Article] = Article.placeholders
  var isLoading: Bool {
    return articles == Article.placeholders
  }
  private var articleWorker: any ArticleWorker
  private let router: any ArticlesRouting

  init(articleWorker: any ArticleWorker, router: any ArticlesRouting) {
    self.router = router
    self.articleWorker = articleWorker
    self.articleWorker.delegate = self
  }

  @MainActor
  func viewDidLoad() async {
    do {
      let articles = try await articleWorker.articles(query: "apple", perPage: 12)
      self.articles = articles
    } catch {
      if isLoading {
        articles = []
      }
      dump(error)
      self.error = .error(error)
    }
  }

  func didTapOnArticle(_ article: Article) {
    router.routeToArticleDetails(link: article.link)
  }
}

extension ArticlesViewModel: ArticleWorkerDelegate {

  @MainActor
  func didUpdateArticles(_ articles: [Article], type: ArticleUpdate) async {
    switch type {
    case .reset:
      self.articles = articles
    case .update:
      self.articles += articles
    }
  }
}
