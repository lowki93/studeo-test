//
//  DataRequest.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Alamofire
import Foundation

extension DataRequest {

  func validateStatusCode() -> Self {
    return validate { _, response, data in
      switch response.statusCode {
      case 200..<300:
        return .success(())
      case 401:
        return .failure(NetworkError.unauthorized)
      default:
        if let data, let payload = try? DefaultDecoderService().decode(NetworkErrorPayload.self, from: data) {
          return .failure(NetworkError.custom(code: response.statusCode, message: payload.message))
        } else {
          return .failure(NetworkError.code(response.statusCode))
        }
      }
    }
  }
}
