//
//  NewsView.swift
//  StudeoTest
//
//  Created by Kevin Budain on 17/05/2023.
//

import SwiftUI

struct NewsView: View {

  @ObservedObject var viewModel: NewsViewModel

  var body: some View {
    List(viewModel.news) { news in
      NewsRow(news: news)
    }
    .listStyle(.grouped)
    .navigationTitle("News")
    .redacted(reason: viewModel.news == News.placeholders ? .placeholder : [])
    .toast(configuration: $viewModel.error)
  }
}
