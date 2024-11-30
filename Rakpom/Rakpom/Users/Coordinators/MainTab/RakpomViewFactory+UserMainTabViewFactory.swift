//
//  RakpomViewFactory+UserMainTabViewFactory.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: UserMainTabViewFactory {
  func makeUserMainTabPrizeListView() -> AnyView {
    let url = Config.apiURL.appending(path: "users/prizes")
    let service = AlamofirePrizeListService(url: url, client: client)
    let viewModel = PrizeListViewModel(service: service)
    let view = PrizeListView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeUserMainTabShopListView(onShopSelected: @escaping (ShopItem) -> Void) -> AnyView {
    let shopListURL = Config.apiURL.appending(path: "users/shops/pages")
    let shopListService = AlamofireShopListService(url: shopListURL, client: client)

    let recentBookingURL = Config.apiURL.appending(path: "users/shops/recent")
    let recentBookingService = AlamofireRecentBookingService(url: recentBookingURL, client: client)

    let viewModel = ShopListViewModel(
      recentBookingService: recentBookingService,
      shopListService: shopListService,
      onShopSelected: onShopSelected)
    let view = ShopListView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeUserMainTabBookingHistoryView() -> AnyView {
    let url = Config.apiURL.appending(path: "users/booking_history_items/pages")
    let service = AlamofireBookingHistoryService(url: url, client: client)
    let viewModel = BookingHistoryViewModel(service: service)
    let view = BookingHistoryView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeUserMainTabNotificationListView() -> AnyView {
    let url = Config.apiURL.appending(path: "users/notifications/pages")
    let service = AlamofireNotificationListService(url: url, client: client)
    let viewModel = NotificationListViewModel(service: service)
    let view = NotificationListView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeUserMainTabPaymentSelectionView(onConfirmed: @escaping (PaymentMethod) -> Void) -> AnyView {
    let view = PaymentMethodSelectionView(onConfirmed: onConfirmed)
    return AnyView(view)
  }
}
