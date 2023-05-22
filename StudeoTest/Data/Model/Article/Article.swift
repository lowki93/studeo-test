//
//  Article.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct Article: Identifiable, Equatable {
  let id: UUID
  let title: String
  let image: URL?
  let description: String
  let link: URL
  let publishedAt: Date
  let source: String

  static let placeholders: [Article] = [
    placeholder(id: "1"),
    placeholder(id: "2"),
    placeholder(id: "3"),
    placeholder(id: "4"),
    placeholder(id: "5"),
    placeholder(id: "6"),
    placeholder(id: "7"),
    placeholder(id: "8"),
    placeholder(id: "9"),
    placeholder(id: "10")
  ]
  private static func placeholder(id: String) -> Article {
    return Article(
      id: UUID(uuidString: id) ?? UUID(),
      title: "title for plaholder",
      image: nil,
      description: "description for plaholder",
      link: URL(stringLiteral: "https://google.com"),
      publishedAt: Date(),
      source: "source"
    )
  }
}
