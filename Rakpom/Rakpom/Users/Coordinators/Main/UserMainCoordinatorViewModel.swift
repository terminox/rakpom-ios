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
    onShopSelected: @escaping (ShopItem) -> Void,
    onPaymentMethodSelected: @escaping (PaymentMethod) -> Void) -> AnyView

  func makeUserMainShopDetailView(for shop: ShopItem) -> AnyView
  func makeUserMainPaymentView(for paymentMethod: PaymentMethod) -> AnyView
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
    onShopSelected: { [weak self] in self?.displayShopDetail($0) },
    onPaymentMethodSelected: { [weak self] in self?.displayPayment($0) })

  func view(for node: UserMainCoordinatorNode) -> AnyView {
    switch node {
    case .tab:
      return rootView
    case .shopDetail:
      return rootView
    case .payment:
      guard let paymentMethod = paymentMethod else { return AnyView(EmptyView()) }
      return factory.makeUserMainPaymentView(for: paymentMethod)
    case .points:
      return rootView
    case .settings:
      return rootView
    }
  }

  func back() {
    _ = path.removeLast()
  }
  
  func displayShopDetail(_ shop: ShopItem) {
    self.shop = shop
    path.append(.shopDetail)
  }

  func displayPayment(_ paymentMethod: PaymentMethod) {
    self.paymentMethod = paymentMethod
    path.append(.payment)
  }

  // MARK: Private

  private var shop: ShopItem?
  private var paymentMethod: PaymentMethod?
  
}

// MARK: - UserMainCoordinatorNode

enum UserMainCoordinatorNode: Hashable {
  case tab
  case shopDetail
  case payment
  case points
  case settings
}
