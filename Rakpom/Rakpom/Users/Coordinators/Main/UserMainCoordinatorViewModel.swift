//
//  UserMainCoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import SwiftUI

// MARK: - UserMainCoordinatorViewFactory

protocol UserMainCoordinatorViewFactory {
  func makeUserMainTabView(
    onAvatarPressed: @escaping () -> Void,
    onHomePressed: @escaping () -> Void,
    onPointPressed: @escaping () -> Void,
    onSearchClicked: @escaping () -> Void,
    onShopSelected: @escaping () -> Void,
    onPaymentMethodSelected: @escaping () -> Void) -> AnyView

  func makeUserMainShopDetailView() -> AnyView
  func makeUserMainPaymentView() -> AnyView
  func makeUserMainPointsView() -> AnyView
  func makeUserMainSettingsView() -> AnyView
}

// MARK: - UserMainCoordinatorViewModel

class UserMainCoordinatorViewModel: ObservableObject {

  // MARK: Lifecycle

  init(factory: UserMainCoordinatorViewFactory) {
    self.factory = factory
  }

  // MARK: Internal

  let factory: UserMainCoordinatorViewFactory

  @Published var path: [UserMainCoordinatorNode] = []

  lazy var rootView = factory.makeUserMainTabView(
    onAvatarPressed: {},
    onHomePressed: {},
    onPointPressed: {},
    onSearchClicked: {},
    onShopSelected: {},
    onPaymentMethodSelected: {})

  func view(for node: UserMainCoordinatorNode) -> AnyView {
    switch node {
    case .tab:
      return rootView
    case .shopDetail:
      return rootView
    case .payment:
      return rootView
    case .points:
      return rootView
    case .settings:
      return rootView
    }
  }

  func back() {
    _ = path.removeLast()
  }
}

// MARK: - UserMainCoordinatorNode

enum UserMainCoordinatorNode: Hashable {
  case tab
  case shopDetail
  case payment
  case points
  case settings
}
