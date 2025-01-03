//
//  RakpomViewFactory+ShopMainCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: ShopMainCoordinatorViewFactory {
  func makeShopMainTabView(onAvatarPressed: @escaping () -> Void, onHomePressed: @escaping () -> Void, onWithdrawHistoryPressed: @escaping () -> Void) -> AnyView {
    let url = Config.apiURL.appending(path: "shops/profiles/me")
    let service = AlamofireShopAppScaffoldService(url: url, client: client)
    let viewModel = ShopAppScaffoldViewModel(service: service)
    let view = ShopAppScaffold(viewModel: viewModel, onSettingsPressed: onAvatarPressed) {
      ShopMainTabView(factory: self, onWithdrawHistoryPressed: onWithdrawHistoryPressed)
    }
    return AnyView(view)
  }
  
  func makeShopWithdrawHistoryView() -> AnyView {
    let service = AlamofireWithdrawHistoryListFetchingService(baseURL: Config.apiURL, tokenManager: tokenManager)
    let viewModel = WithdrawHistoryViewModel(withdrawHistoryListFetchingService: service)
    let view = BackScaffold(title: "ประวัติการถอนเงิน") {
      WithdrawHistoryView(viewModel: viewModel)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }
  
  func makeShopMainSettingsView(onUpdateProfilePressed: @escaping () -> Void, onLogout: @escaping () -> Void) -> AnyView {
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
  
  func makeShopMainUpdateProfileView(onCompleted: @escaping () -> Void) -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }
}
