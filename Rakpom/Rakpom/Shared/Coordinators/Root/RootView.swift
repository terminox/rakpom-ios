//
//  RootView.swift
//  Rakpom
//
//  Created by yossa on 19/11/2567 BE.
//

import SwiftUI

struct RootView: View {
  
  @ObservedObject var viewModel: RootViewModel
  
  var body: some View {
    viewModel.anyView
      .onAppear(perform: viewModel.onAppear)
  }
}
