//
//  ShopMainCoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import SwiftUI

// MARK: - ShopMainCoordinatorViewFactory

protocol ShopMainCoordinatorViewFactory {
  func makeShopMainTabView(
    onSettingsPressed: @escaping () -> Void,
    onWithdrawHistoryPressed: @escaping () -> Void)
  -> AnyView

  func makeShopWithdrawHistoryView() -> AnyView

  func makeShopMainSettingsView(
    onUpdateProfilePressed: @escaping () -> Void,
    onAboutUsPressed: @escaping () -> Void,
    onLogout: @escaping () -> Void)
    -> AnyView

  func makeShopMainUpdateProfileView(onCompleted: @escaping () -> Void) -> AnyView
  
  func makeShopMainSettingsAboutUs() -> AnyView
}

// MARK: - ShopMainCoordinatorViewModel

class ShopMainCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(
    mainFactory: any ShopMainCoordinatorViewFactory,
    onLogoutPressed: @escaping () -> Void)
  {
    self.mainFactory = mainFactory
    self.onLogoutPressed = onLogoutPressed
  }

  // MARK: Internal

  typealias Node = ShopMainCoordinatorNode

  let mainFactory: any ShopMainCoordinatorViewFactory
  let onLogoutPressed: () -> Void

  @Published var path: [Node] = []

  lazy var rootView = mainFactory.makeShopMainTabView(
    onSettingsPressed: { [weak self] in self?.displaySettings() },
    onWithdrawHistoryPressed: { [weak self] in self?.displayWithdrawHistory() })

  var pathPublished: Published<[Node]> { _path }
  var pathPublisher: Published<[Node]>.Publisher { $path }

  func view(for node: ShopMainCoordinatorNode) -> AnyView {
    switch node {
    case .tab:
      return rootView
      
    case .settings:
      return mainFactory.makeShopMainSettingsView(
        onUpdateProfilePressed: { [weak self] in self?.displayUpdateProfile() },
        onAboutUsPressed: { [weak self] in self?.displayAboutUs() },
        onLogout: onLogoutPressed)
      
    case .updateProfile:
      return mainFactory.makeShopMainUpdateProfileView(onCompleted: { [weak self] in self?.reset() })
      
    case .aboutUs:
      return mainFactory.makeShopMainSettingsAboutUs()
      
    case .withdrawHistory:
      return mainFactory.makeShopWithdrawHistoryView()
    }
  }
  
  func displaySettings() {
    path.append(.settings)
  }

  func displayUpdateProfile() {
    path.append(.updateProfile)
  }
  
  func displayAboutUs() {
    path.append(.aboutUs)
  }
  
  func displayWithdrawHistory() {
    path.append(.withdrawHistory)
  }

  func reset() {
    path = []
  }

  // MARK: Private

  private var shop: ShopItem?
  private var bookingConfirmationItems: [BookingConfirmationDetailItem]?
  private var paymentMethod: PaymentMethod?
  private var shopCode: String?

}

// MARK: - ShopMainCoordinatorNode

enum ShopMainCoordinatorNode: Hashable {
  case tab
  case settings
  case updateProfile
  case aboutUs
  case withdrawHistory
}
