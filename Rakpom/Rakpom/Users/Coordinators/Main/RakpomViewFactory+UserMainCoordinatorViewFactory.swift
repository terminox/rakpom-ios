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
    onHomePressed: @escaping () -> Void,
    onPointPressed: @escaping () -> Void,
    onSearchClicked: @escaping () -> Void,
    onShopSelected: @escaping () -> Void,
    onPaymentMethodSelected: @escaping () -> Void)
    -> AnyView
  {
    let url = Config.apiURL.appending(path: "users/profiles/me")
    let service = AlamofireUserAppScaffoldService(url: url, client: client)
    let scaffoldViewModel = UserAppScaffoldViewModel(service: service)
    let view = UserAppScaffold(viewModel: scaffoldViewModel, onAvatarPressed: onAvatarPressed, onPointPressed: onPointPressed) {
      UserMainTabView(factory: self)
    }
    
    return AnyView(view)
  }

  func makeUserMainShopDetailView() -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }

  func makeUserMainPaymentView() -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }

  func makeUserMainPointsView() -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }

  func makeUserMainSettingsView() -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }
}
