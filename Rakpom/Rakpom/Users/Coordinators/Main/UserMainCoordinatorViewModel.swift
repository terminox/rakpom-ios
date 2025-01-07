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
    onSettingsPressed: @escaping () -> Void,
    onPointPressed: @escaping () -> Void,
    onSearchClicked: @escaping () -> Void,
    onShopSelected: @escaping (ShopItem) -> Void,
    onPaymentMethodSelected: @escaping (PaymentMethod) -> Void)
    -> AnyView

  func makeUserMainPointsView() -> AnyView

  func makeUserMainSettingsView(
    onUpdateProfilePressed: @escaping () -> Void,
    onAboutUsPressed: @escaping () -> Void,
    onLogout: @escaping () -> Void)
    -> AnyView
  
  func makeUserMainUpdateProfile(onCompleted: @escaping () -> Void) -> AnyView
  
  func makeUserMainSettingsAboutUs() -> AnyView
}

// MARK: - UserMainCoordinatorViewModel

class UserMainCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(
    mainFactory: any UserMainCoordinatorViewFactory,
    shopFactory: any ShopCoordinatorViewFactory,
    paymentFactory: any PaymentCoordinatorViewFactory,
    onLogoutPressed: @escaping () -> Void)
  {
    self.mainFactory = mainFactory
    self.shopFactory = shopFactory
    self.paymentFactory = paymentFactory
    self.onLogoutPressed = onLogoutPressed
  }

  // MARK: Internal

  typealias Node = UserMainCoordinatorNode

  let mainFactory: any UserMainCoordinatorViewFactory
  let shopFactory: any ShopCoordinatorViewFactory
  let paymentFactory: any PaymentCoordinatorViewFactory
  let onLogoutPressed: () -> Void

  @Published var path: [Node] = []

  lazy var rootView = mainFactory.makeUserMainTabView(
    onSettingsPressed: { [weak self] in self?.displaySettings() },
    onPointPressed: { [weak self] in self?.displayPoints() },
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

    case .points:
      return mainFactory.makeUserMainPointsView()

    case .settings:
      return mainFactory.makeUserMainSettingsView(
        onUpdateProfilePressed: { [weak self] in self?.displayUpdateProfile() },
        onAboutUsPressed: { [weak self] in self?.displayAboutUs() },
        onLogout: { [weak self] in self?.onLogoutPressed() })
      
    case .updateProfile:
      return mainFactory.makeUserMainUpdateProfile(onCompleted: { [weak self] in self?.reset() })
      
    case .aboutUs:
      return mainFactory.makeUserMainSettingsAboutUs()

    case .reviewList:
      guard let shop = shop else { return AnyView(EmptyView()) }
      return shopFactory.makeShopReviewListView(for: shop)

    case .bookingConfirmation:
      guard let items = bookingConfirmationItems else { return AnyView(EmptyView()) }
      return shopFactory.makeShopBookingConfirmationView(for: items, onConfirmed: { [weak self] in self?.reset() })

    case .payment:
      guard let paymentMethod = paymentMethod else { return AnyView(EmptyView()) }
      return paymentFactory.makePaymentCoordinatorPaymentView(
        for: paymentMethod,
        onCompleted: { [weak self] in
          self?.shopCode = $0
          self?.displayPaymentCompletion()
        })

    case .paymentCompletion:
      return paymentFactory.makePaymentCoordinatorPaymentCompletionView(
        onConfirmed: { [weak self] in self?.displayFeedback() },
        onCanceled: { [weak self] in self?.reset() })

    case .feedback:
      guard let shopCode = shopCode else { return AnyView(EmptyView()) }
      return paymentFactory.makePaymentCoordinatorFeedbackView(
        for: shopCode,
        onCompleted: { [weak self] in self?.displayFeedbackCompletion() },
        onCanceled: { [weak self] in self?.reset() })

    case .feedbackCompletion:
      return paymentFactory.makePaymentCoordinatorFeedbackCompletionView(onCompleted: { [weak self] in self?.reset() })
    }
  }

  func displayPoints() {
    path.append(.points)
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

  func displayUpdateProfile() {
    path.append(.updateProfile)
  }
  
  func displayAboutUs() {
    path.append(.aboutUs)
  }

  func displayReviewList() {
    path.append(.reviewList)
  }

  func displayConfirmation(_ items: [BookingConfirmationDetailItem]) {
    bookingConfirmationItems = items
    path.append(.bookingConfirmation)
  }

  func displayPaymentCompletion() {
    path.append(.paymentCompletion)
  }

  func displayFeedback() {
    path.append(.feedback)
  }

  func displayFeedbackCompletion() {
    path.append(.feedbackCompletion)
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

// MARK: - UserMainCoordinatorNode

enum UserMainCoordinatorNode: Hashable {
  case tab
  case shopDetail
  case points
  case settings
  case updateProfile
  case aboutUs
  case reviewList
  case bookingConfirmation
  case payment
  case paymentCompletion
  case feedback
  case feedbackCompletion
}
