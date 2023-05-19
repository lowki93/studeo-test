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
    let endpoint = generateEndpoint(source: source, query: query, perPage: perPage)
    let data = try await client.request(url: endpoint.url, method: .get, parameters: endpoint.params)
    do {
      let payload = try decoder.decode(EverythingNewsApiNetworkPayload.self, from: data)
      return try payload.toModel()
    } catch {
      throw error
    }
  }

  private func generateEndpoint(source: NewsSource, query: String, perPage: Int) -> (url: URL, params: [String: Any]) {
    switch source {
    case .newsApi:
      return (
        url: .newsApi.appending(path: NewsPath.everything.rawValue),
        params: ["apiKey": Key.News.newsApi, "q": query, "pageSize": perPage]
      )
    case .gnews:
      return (
        url: .gnews.appending(path: NewsPath.search.rawValue),
        params: ["apikey": Key.News.gnews, "q": query, "max": perPage]
      )
    }
  }

}
