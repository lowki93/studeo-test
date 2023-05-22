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
      Button {
        viewModel.didTapOnNews(news: news)
      } label: {
        NewsRow(news: news)
      }
    }
    .listStyle(.grouped)
    .navigationTitle(L10n.News.Navigation.title)
    .redacted(reason: viewModel.isLoading ? .placeholder : [])
    .toast(configuration: $viewModel.error)
  }
}
