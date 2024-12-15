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
  func makeUserMainPaymentView(for paymentMethod: PaymentMethod, onCompleted: @escaping () -> Void) -> AnyView
  func makeUserMainPointsView() -> AnyView
  func makeUserMainSettingsView() -> AnyView
}

// MARK: - UserMainCoordinatorViewModel

class UserMainCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(factory: UserMainCoordinatorViewFactory) {
    self.factory = factory
  }

  // MARK: Internal

  typealias Node = UserMainCoordinatorNode

  let factory: UserMainCoordinatorViewFactory

  @Published var path: [Node] = []
  
  lazy var rootView = factory.makeUserMainTabView(
    onAvatarPressed: { [weak self] in self?.displaySettings() },
    onHomePressed: { }, // Do nothing here
    onPointPressed: {},
    onSearchClicked: {},
    onShopSelected: { [weak self] in self?.displayShopDetail($0) },
    onPaymentMethodSelected: { [weak self] in self?.displayPayment($0) })

  var pathPublished: Published<[Node]> { _path }
  var pathPublisher: Published<[Node]>.Publisher { $path }

  func view(for node: UserMainCoordinatorNode) -> AnyView {
    switch node {
    case .tab:
      return rootView
    case .shopDetail:
      return rootView
    case .payment:
      guard let paymentMethod = paymentMethod else { return AnyView(EmptyView()) }
      return factory.makeUserMainPaymentView(for: paymentMethod, onCompleted: { [weak self] in self?.reset() })
    case .points:
      return rootView
    case .settings:
      return factory.makeUserMainSettingsView()
    }
  }

  func displayShopDetail(_ shop: ShopItem) {
    self.shop = shop
    path.append(.shopDetail)
  }

  func displayPayment(_ paymentMethod: PaymentMethod) {
    self.paymentMethod = paymentMethod
    path.append(.payment)
  }

  func displaySettings() {
    path.append(.settings)
  }
  
  func reset() {
    path = []
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
