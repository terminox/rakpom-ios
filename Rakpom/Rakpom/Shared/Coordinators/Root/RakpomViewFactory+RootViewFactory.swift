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

  func makeRootUserProfileFormView(onCompleted: @escaping () -> Void) -> AnyView {
    let service = AggregatedUserProfileUpdatingService(baseURL: Config.apiURL, tokenManager: tokenManager, imageUploadingService: imageUploader)
    let viewModel = UserProfileFormViewModel(service: service, onComplete: onCompleted)
    let view = BackScaffold(title: "ลงทะเบียน") {
      UserProfileFormView(viewModel: viewModel)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeRootShopProfileFormView(onCompleted: @escaping () -> Void) -> AnyView {
    let service = AggregatedShopProfileService(baseURL: Config.apiURL, tokenManager: tokenManager, imageUploadingService: imageUploader)
    let viewModel = ShopProfileFormViewModel(service: service, onComplete: onCompleted)
    let view = BackScaffold(title: "ลงทะเบียน") {
      ShopProfileFormView(viewModel: viewModel)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeRootMainView(onLogout: @escaping () -> Void) -> AnyView {
    let viewModel = UserMainCoordinatorViewModel(
      mainFactory: self,
      shopFactory: self,
      paymentFactory: self,
      onLogoutPressed: onLogout)
    let view = StackCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeRootShopMainView(onLogout: @escaping () -> Void) -> AnyView {
    let viewModel = ShopMainCoordinatorViewModel(
      mainFactory: self,
      onLogoutPressed: onLogout)
    let view = StackCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }
}
