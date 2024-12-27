//
//  RakpomViewFactory+RootViewFactory.swift
//  Rakpom
//
//  Created by yossa on 19/11/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: RootViewFactory {
  func makeRootSplashView() -> AnyView {
    let view = LaunchView()
    return AnyView(view)
  }

  func makeRootSignupView(onSignupCompleted: @escaping (SignupResult) -> Void) -> AnyView {
    let viewModel = SignupCoordinatorViewModel(factory: self, onCompleted: onSignupCompleted)
    let view = SignupCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeRootUserProfileFormView(onCompleted _: @escaping () -> Void) -> AnyView {
    // TODO
    AnyView(EmptyView())
  }

  func makeRootShopProfileFormView(onCompleted _: @escaping () -> Void) -> AnyView {
    // TODO
    AnyView(EmptyView())
  }

  func makeRootMainView(onLogout _: @escaping () -> Void) -> AnyView {
    let viewModel = UserMainCoordinatorViewModel(mainFactory: self, shopFactory: self)
    let view = StackCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeRootShopMainView(onLogout _: @escaping () -> Void) -> AnyView {
    // TODO
    AnyView(EmptyView())
  }
}
