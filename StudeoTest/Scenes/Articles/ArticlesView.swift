//
//  ArticlesView.swift
//  StudeoTest
//
//  Created by Kevin Budain on 17/05/2023.
//

import SwiftUI

struct ArticlesView: View {

  @StateObject var viewModel: ArticlesViewModel

  var body: some View {
    List(viewModel.articles) { article in
      Button {
        viewModel.didTapOnArticle(article)
      } label: {
        ArticleRow(article: article)
      }
    }
    .listStyle(.grouped)
    .navigationTitle(L10n.Article.Navigation.title)
    .redacted(reason: viewModel.isLoading ? .placeholder : [])
    .toast(configuration: $viewModel.error)
  }
}
