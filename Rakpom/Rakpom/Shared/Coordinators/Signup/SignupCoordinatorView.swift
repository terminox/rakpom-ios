//
//  SignupCoordinatorView.swift
//  Rakpom
//
//  Created by yossa on 20/11/2567 BE.
//

import SwiftUI

struct SignupCoordinatorView: View {
  
  @ObservedObject var viewModel: SignupCoordinatorViewModel

  var body: some View {
    NavigationStack(path: $viewModel.path) {
      viewModel.rootView
        .navigationDestination(for: SignupCoordinatorNode.self) { node in
          viewModel.view(for: node)
        }
    }
  }
}
