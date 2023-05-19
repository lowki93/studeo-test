//
//  NewsViewModel.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation
import Alamofire

final class NewsViewModel: ObservableObject, ViewLifeCycle {
  private var worker: NewsWorker

  init() {
    worker = DefaultNewsWorker(newsNetworkService: DefaultNewsNetworkService(client: DefaultNetworkClient(session: Session.default)))
    worker.delegate = self
  }

  func viewDidLoad() async {
    do {
      let news = try await worker.news(query: "apple", perPage: 2)
      dump(news)
    } catch {
      print("Error ==>\(error)")
    }
  }
}

extension NewsViewModel: NewsWorkerDelegate {

  func didUpdateNews(_ news: [News], from source: NewsSource) {
    dump("---> \(source) - \(news.count)")
  }
}
