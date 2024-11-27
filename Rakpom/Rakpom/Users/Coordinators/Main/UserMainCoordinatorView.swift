//
//  UserMainCoordinatorView.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import SwiftUI

struct UserMainCoordinatorView: View {
  
  @ObservedObject var viewModel: UserMainCoordinatorViewModel

  var body: some View {
    NavigationStack(path: $viewModel.path) {
      viewModel.rootView
        .navigationDestination(for: UserMainCoordinatorNode.self) { node in
          viewModel.view(for: node)
        }
    }
  }
}
