//
//  DefaultArticleNetworkService.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct DefaultArticleNetworkService: ArticleNetworkService {

  private let client: any NetworkClient
  private let decoder: any DecoderService = DefaultDecoderService()

  init(client: any NetworkClient) {
    self.client = client
  }

  func articles(from source: ArticleSource, query: String, perPage: Int) async throws -> [Article] {
    let endpoint = generateNewsEndpoint(source: source, query: query, perPage: perPage)
    let data = try await client.request(url: endpoint.url, method: .get, parameters: endpoint.params)
    do {
      return try decodingNews(data: data, from: source)
    } catch {
      throw error
    }
  }

  private func generateNewsEndpoint(source: ArticleSource, query: String, perPage: Int) -> (url: URL, params: [String: Any]) {
    switch source {
    case .newsApi:
      return (
        url: .newsApi.appending(path: ArticlePath.everything.rawValue),
        params: ["apiKey": Key.News.newsApi, "q": query, "pageSize": perPage, "language": "en"]
      )
    case .gnews:
      return (
        url: .gnewsApi.appending(path: ArticlePath.search.rawValue),
        params: ["apikey": Key.News.gnews, "q": query, "max": perPage, "lang": "en"]
      )
    case .theNewsApi:
      return (
        url: .theNewsApi.appending(path: ArticlePath.all.rawValue),
        params: ["api_token": Key.News.theNewsApi, "search": query, "limit": perPage, "languages": "en"]
      )
    }
  }

  private func decodingNews(data: Data, from source: ArticleSource) throws -> [Article] {
    switch source {
    case .newsApi:
      let payload = try decoder.decode(EverythingNewsApiNetworkPayload.self, from: data)
      return try payload.toModel()
    case .gnews:
      let payload = try decoder.decode(SearchGNewsNetworkPayload.self, from: data)
      return try payload.toModel()
    case .theNewsApi:
      let payload = try decoder.decode(NewsTheNewsApiNetworkPayload.self, from: data)
      return try payload.toModel()
    }
  }
}
