//
//  NetwotkClient.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation
import Alamofire

protocol NetworkClient {
  @discardableResult func request(url: URL, method: URLRequest.HTTPMethod, parameters: [String: Any]?) async throws -> Data
}

struct DefaultNetworkClient: NetworkClient {

  private let session: Session

  init(session: Session) {
    self.session = session
  }

  @discardableResult func request(url: URL, method: URLRequest.HTTPMethod, parameters: [String : Any]?) async throws -> Data {
    let result =  await session
      .request(url, method: method.value, parameters: parameters)
      .validateStatusCode()
      .serializingData()
      .result

    switch result {
    case .success(let data):
//      logService.log(event: .urlNetwork(.success(url: url, method: method)))
      return data
    case .failure(let error):
//      logService.log(event: .urlNetwork(.failure(url: url, method: method, error: error.underlyingError ?? error)))
      throw error.underlyingError ?? error
    }
  }
}
