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

  func makeUserMainPaymentView(for paymentMethod: PaymentMethod, onCompleted: @escaping () -> Void) -> AnyView {
    let viewModel = PaymentCoordinatorViewModel(paymentMethod: paymentMethod, factory: self, onCompleted: onCompleted)
    let view = StackCoordinatorView(viewModel: viewModel)
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeUserMainPointsView() -> AnyView {
    let service = AlamofirePointListService(baseURL: Config.apiURL, tokenManager: tokenManager)
    let viewModel = PointListViewModel(service: service)
    let view = BackScaffold(title: "แต้มของคุณ") {
      PointListView(viewModel: viewModel)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeUserMainSettingsView(onLogout: @escaping () -> Void) -> AnyView {
    let privacyPolicyUrl = URL(string: "https://certain-fuchsia-42f.notion.site/Privacy-Policy-for-Rakpom-1446d267341680008e8bf56e68260c8c?pvs=4")!
    let termsUrl = URL(string: "https://certain-fuchsia-42f.notion.site/Terms-of-Use-for-Rakpom-1456d267341680ceb34fd04aea1aa191?pvs=4")!
    
    let openURL: (URL) -> Void = { url in
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
      }
    }
    
    let view = SettingsView(
      onProfilePressed: {
        // TODO
      },
      onAboutUsPressed: {
        // TODO
      },
      onPrivacyPolicyPressed: { openURL(privacyPolicyUrl) },
      onTermsPressed: { openURL(termsUrl) },
      onLogoutPressed: { [weak self] in
        onLogout()
        try? self?.tokenManager.clearToken()
      })
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }
}
