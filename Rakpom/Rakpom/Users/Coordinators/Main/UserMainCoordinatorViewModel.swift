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

  func makeUserMainPaymentView(for paymentMethod: PaymentMethod, onCompleted: @escaping () -> Void) -> AnyView
  func makeUserMainPointsView() -> AnyView
  func makeUserMainSettingsView() -> AnyView
}

// MARK: - UserMainCoordinatorViewModel

class UserMainCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(
    mainFactory: any UserMainCoordinatorViewFactory,
    shopFactory: any ShopCoordinatorViewFactory)
  {
    self.mainFactory = mainFactory
    self.shopFactory = shopFactory
  }

  // MARK: Internal

  typealias Node = UserMainCoordinatorNode

  let mainFactory: any UserMainCoordinatorViewFactory
  let shopFactory: any ShopCoordinatorViewFactory

  @Published var path: [Node] = []

  lazy var rootView = mainFactory.makeUserMainTabView(
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
      guard let shop = shop else { return AnyView(EmptyView()) }
      return shopFactory.makeShopDetailView(
        for: shop,
        onReviewsPressed: { [weak self] in self?.displayReviewList() },
        onConfirmed: { [weak self] in self?.displayConfirmation($0) })
      
    case .payment:
      guard let paymentMethod = paymentMethod else { return AnyView(EmptyView()) }
      return mainFactory.makeUserMainPaymentView(for: paymentMethod, onCompleted: { [weak self] in self?.reset() })
      
    case .points:
      return rootView
      
    case .settings:
      return mainFactory.makeUserMainSettingsView()
      
    case .reviewList:
      guard let shop = shop else { return AnyView(EmptyView()) }
      return shopFactory.makeShopReviewListView(for: shop)

    case .bookingConfirmation:
      guard let items = bookingConfirmationItems else { return AnyView(EmptyView()) }
      return shopFactory.makeShopBookingConfirmationView(for: items, onConfirmed: { [weak self] in self?.reset() })
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

  func displayReviewList() {
    path.append(.reviewList)
  }

  func displayConfirmation(_ items: [BookingConfirmationDetailItem]) {
    bookingConfirmationItems = items
    path.append(.bookingConfirmation)
  }

  func reset() {
    path = []
  }

  // MARK: Private

  private var shop: ShopItem?
  private var bookingConfirmationItems: [BookingConfirmationDetailItem]?
  private var paymentMethod: PaymentMethod?

}

// MARK: - UserMainCoordinatorNode

enum UserMainCoordinatorNode: Hashable {
  case tab
  case shopDetail
  case payment
  case points
  case settings
  case reviewList
  case bookingConfirmation
}
