//
//  RakpomViewFactory+UserMainCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: UserMainCoordinatorViewFactory {
  func makeUserMainTabView(
    onAvatarPressed: @escaping () -> Void,
    onHomePressed _: @escaping () -> Void,
    onPointPressed: @escaping () -> Void,
    onSearchClicked _: @escaping () -> Void,
    onShopSelected: @escaping (ShopItem) -> Void,
    onPaymentMethodSelected: @escaping (PaymentMethod) -> Void)
    -> AnyView
  {
    let url = Config.apiURL.appending(path: "users/profiles/me")
    let service = AlamofireUserAppScaffoldService(url: url, client: client)
    let scaffoldViewModel = UserAppScaffoldViewModel(service: service)
    let view = UserAppScaffold(viewModel: scaffoldViewModel, onAvatarPressed: onAvatarPressed, onPointPressed: onPointPressed) {
      UserMainTabView(factory: self, onShopSelected: onShopSelected, onPaymentMethodConfirmed: onPaymentMethodSelected)
    }

    return AnyView(view)
  }

  func makeUserMainShopDetailView(for shop: ShopItem) -> AnyView {
    let viewModel = ShopCoordinatorViewModel(factory: self, shop: shop)
    let view = StackCoordinatorView(viewModel: viewModel)
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeUserMainPaymentView(for paymentMethod: PaymentMethod, onCompleted: @escaping () -> Void) -> AnyView {
    let viewModel = PaymentCoordinatorViewModel(paymentMethod: paymentMethod, factory: self, onCompleted: {})
    let view = StackCoordinatorView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeUserMainPointsView() -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }

  func makeUserMainSettingsView() -> AnyView {
    // TODO
    let view = SettingsView(
      onProfilePressed: {},
      onAboutUsPressed: {},
      onPrivacyPolicyPressed: {},
      onTermsPressed: {},
      onLogoutPressed: {})
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }
}
