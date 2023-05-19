//
//  News.swift
//  StudeoTest
//
//  Created by Kevin Budain on 18/05/2023.
//

import Foundation

struct News: Identifiable {
  let id: UUID
  let title: String
  let image: URL?
  let description: String
  let link: URL
  let publishedAt: Date
  let source: String
}
