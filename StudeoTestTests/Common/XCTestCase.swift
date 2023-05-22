//
//  XCTestCase.swift
//  StudeoTestTests
//
//  Created by Kevin Budain on 22/05/2023.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import StudeoTest

extension XCTestCase {

  func createNetworkClient() -> DefaultNetworkClient {
    return DefaultNetworkClient(session: .default)
  }

  func setupStub(forFile filename: String, statusCode: Int32, in file: String = #file) {
    stub { _ in
      return true
    } response: { _ in
      let directory = URL(fileURLWithPath: file).deletingLastPathComponent()
      let path = directory.appendingPathComponent("Response/\(filename).json").relativePath
      let response = HTTPStubsResponse(fileAtPath: path, statusCode: statusCode, headers: [:])
      return response
    }
  }

  func removeAllStubs() {
    HTTPStubs.removeAllStubs()
  }

  func XCTAssertAsyncThrowsError<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: any Error) -> Void = { _ in }
  ) async {
    do {
      _ = try await expression()
      XCTFail(message(), file: file, line: line)
    } catch {
      errorHandler(error)
    }
  }
}
