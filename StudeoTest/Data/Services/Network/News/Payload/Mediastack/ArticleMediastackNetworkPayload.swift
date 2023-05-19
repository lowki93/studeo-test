//
//  ArticleMediastackNetworkPayload.swift
//  StudeoTest
//
//  Created by Kevin Budain on 19/05/2023.
//

import Foundation

struct ArticleMediastackNetworkPayload: Decodable, ModelConvertible {

  let title: String
  let description: String
  let url: URL
  let image: URL?
  let publishedAt: Date
  let source: String

  func toModel() throws -> News {
    return News(
      id: UUID(),
      title: title,
      image: image,
      description: description,
      link: url,
      publishedAt: publishedAt,
      source: source
    )
  }

}

//"author": "TMZ Staff",
//            "title": "Rafael Nadal Pulls Out Of U.S. Open Over COVID-19 Concerns",
//            "description": "Rafael Nadal is officially OUT of the U.S. Open ... the tennis legend said Tuesday it's just too damn unsafe for him to travel to America during the COVID-19 pandemic. \"The situation is very complicated worldwide,\" Nadal wrote in a statement. \"The…",
//            "url": "https://www.tmz.com/2020/08/04/rafael-nadal-us-open-tennis-covid-19-concerns/",
//            "source": "TMZ.com",
//            "image": "https://imagez.tmz.com/image/fa/4by3/2020/08/04/fad55ee236fc4033ba324e941bb8c8b7_md.jpg",
//            "category": "general",
//            "language": "en",
//            "country": "us",
//            "published_at": "2020-08-05T05:47:24+00:00"
