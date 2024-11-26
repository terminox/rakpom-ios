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
    let url = Config.apiURL.appending(path: "users/profiles/me")
    let service = AlamofireUserAppScaffoldService(url: url, client: client)
    let scaffoldViewModel = UserAppScaffoldViewModel(service: service)
    let view = UserAppScaffold(viewModel: scaffoldViewModel, onAvatarPressed: {}, onPointPressed: {}) {
      CustomerMainView()
    }
    .task {
      await scaffoldViewModel.fetch()
    }

    return AnyView(view)
  }

  func makeRootShopMainView(onLogout _: @escaping () -> Void) -> AnyView {
    // TODO
    AnyView(EmptyView())
  }
}
