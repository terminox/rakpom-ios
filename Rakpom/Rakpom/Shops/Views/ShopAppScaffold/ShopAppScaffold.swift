//
//  ShopAppScaffold.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import SwiftUI

struct ShopAppScaffold<Content: View>: View {
  
  @ObservedObject var viewModel: ShopAppScaffoldViewModel
  let onSettingsPressed: () -> Void

  @ViewBuilder var content: Content
  
  var body: some View {
    VStack(spacing: .zero) {
      ShopHeaderView(shop: viewModel.shop, onSettingsPressed: onSettingsPressed)

      content
    }
    .task {
      await viewModel.fetch()
    }
  }
}
