//
//  StackCoordinatorView.swift
//  Rakpom
//
//  Created by yossa on 1/12/2567 BE.
//

import SwiftUI

struct StackCoordinatorView<ViewModel: StackCoordinatorViewModel>: View {
  
  @ObservedObject var viewModel: ViewModel
  
  var body: some View {
    NavigationStack(path: $viewModel.path) {
      viewModel.rootView
        .navigationDestination(for: ViewModel.Node.self) { node in
          viewModel.view(for: node)
        }
    }
  }
}
