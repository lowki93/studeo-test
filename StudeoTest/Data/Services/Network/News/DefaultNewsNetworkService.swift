//
//  DefaultNewsNetworkService.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct DefaultNewsNetworkService: NewsNetworkService {

  private let client: any NetworkClient
  private let decoder: any DecoderService = DefaultDecoderService()

  init(client: any NetworkClient) {
    self.client = client
  }

  func news(from source: NewsSource, query: String, perPage: Int) async throws -> [News] {
    let endpoint = generateNewsEndpoint(source: source, query: query, perPage: perPage)
    let data = try await client.request(url: endpoint.url, method: .get, parameters: endpoint.params)
    do {
      return try decodingNews(data: data, from: source)
    } catch {
      throw error
    }
  }

  private func generateNewsEndpoint(source: NewsSource, query: String, perPage: Int) -> (url: URL, params: [String: Any]) {
    switch source {
    case .newsApi:
      return (
        url: .newsApi.appending(path: NewsPath.everything.rawValue),
        params: ["apiKey": Key.News.newsApi, "q": query, "pageSize": perPage, "language": "en"]
      )
    case .gnews:
      return (
        url: .gnewsApi.appending(path: NewsPath.search.rawValue),
        params: ["apikey": Key.News.gnews, "q": query, "max": perPage, "lang": "en"]
      )
    case .mediastack:
      return (
        url: .mediastack.appending(path: NewsPath.news.rawValue),
        params: ["access_key": Key.News.mediastack, "keywords": query, "limit": perPage, "languages": "en"]
      )
    }
  }

  private func decodingNews(data: Data, from source: NewsSource) throws -> [News] {
    switch source {
    case .newsApi:
      let payload = try decoder.decode(EverythingNewsApiNetworkPayload.self, from: data)
      return try payload.toModel()
    case .gnews:
      let payload = try decoder.decode(SearchGNewsNetworkPayload.self, from: data)
      return try payload.toModel()
    case .mediastack:
      let payload = try decoder.decode(NewsMediastackNetworkPayload.self, from: data)
      return try payload.toModel()
    }
  }
}
