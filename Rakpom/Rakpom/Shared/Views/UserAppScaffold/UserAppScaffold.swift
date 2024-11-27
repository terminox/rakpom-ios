//
//  AppScaffold.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import SwiftUI

struct UserAppScaffold<Content: View>: View {
  
  @ObservedObject var viewModel: UserAppScaffoldViewModel
  let onAvatarPressed: () -> Void
  let onPointPressed: () -> Void

  @ViewBuilder var content: Content
  
  var body: some View {
    VStack(spacing: .zero) {
      UserHeaderView(user: viewModel.user, onAvatarPressed: onAvatarPressed, onPointPressed: onPointPressed)

      content
    }
    .task {
      await viewModel.fetch()
    }
  }
}
