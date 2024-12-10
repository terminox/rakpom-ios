//
//  ShopCoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 30/11/2567 BE.
//

import SwiftUI

// MARK: - ShopCoordinatorViewFactory

protocol ShopCoordinatorViewFactory {
  func makeShopDetailView(
    onReviewsPressed: @escaping () -> Void,
    onConfirmed: @escaping (BookingConfirmationDetailItem) -> Void)
    -> AnyView
  func makeShopReviewListView(for shop: ShopItem) -> AnyView
  func makeShopBookingConfirmationView(for detail: BookingConfirmationDetailItem) -> AnyView
}

// MARK: - ShopCoordinatorViewModel

class ShopCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(factory: ShopCoordinatorViewFactory, shop: ShopItem) {
    self.factory = factory
    self.shop = shop
  }

  // MARK: Internal

  typealias Node = ShopCoordinatorNode

  let factory: ShopCoordinatorViewFactory

  @Published var path: [Node] = []
  
  lazy var rootView = factory.makeShopDetailView(
    onReviewsPressed: { [weak self] in self?.displayReviewList() },
    onConfirmed: { [weak self] in self?.displayConfirmation($0) })

  var pathPublished: Published<[ShopCoordinatorNode]> { _path }
  var pathPublisher: Published<[ShopCoordinatorNode]>.Publisher { $path }

  func view(for node: ShopCoordinatorNode) -> AnyView {
    switch node {
    case .shopDetail:
      return rootView

    case .reviewList:
      return factory.makeShopReviewListView(for: shop)

    case .confirmation:
      guard let detail = confirmationDetail else {
        return AnyView(EmptyView())
      }

      return factory.makeShopBookingConfirmationView(for: detail)
    }
  }

  func back() {
    _ = path.removeLast()
  }

  func displayReviewList() {
    path.append(.reviewList)
  }

  func displayConfirmation(_ detail: BookingConfirmationDetailItem) {
    confirmationDetail = detail
    path.append(.confirmation)
  }

  // MARK: Private

  private let shop: ShopItem
  private var confirmationDetail: BookingConfirmationDetailItem?

}

// MARK: - ShopCoordinatorNode

enum ShopCoordinatorNode: Hashable {
  case shopDetail
  case reviewList
  case confirmation
}

// MARK: - BookingConfirmationDetailItem

struct BookingConfirmationDetailItem {

}
