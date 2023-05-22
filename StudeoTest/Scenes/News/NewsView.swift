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
    List(viewModel.articles) { article in
      Button {
        viewModel.didTapOnNews(article: article)
      } label: {
        NewsRow(article: article)
      }
    }
    .listStyle(.grouped)
    .navigationTitle(L10n.News.Navigation.title)
    .redacted(reason: viewModel.isLoading ? .placeholder : [])
    .toast(configuration: $viewModel.error)
  }
}
