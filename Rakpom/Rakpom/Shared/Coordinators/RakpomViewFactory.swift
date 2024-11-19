//
//  RakpomViewFactory.swift
//  Rakpom
//
//  Created by yossa on 19/11/2567 BE.
//

import SwiftUI

class RakpomViewFactory {
  func makeRootView() -> AnyView {
    let viewModel = RootViewModel(factory: self)
    let view = RootView(viewModel: viewModel)
    return AnyView(view)
  }
}
