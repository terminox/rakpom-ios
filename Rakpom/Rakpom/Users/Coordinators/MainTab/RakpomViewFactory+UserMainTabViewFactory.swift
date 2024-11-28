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
  
  func makeUserMainTabShopListView() -> AnyView {
    let shopListURL = Config.apiURL.appending(path: "users/shops/pages")
    let shopListService = AlamofireShopListService(url: shopListURL, client: client)
    
    let recentBookingURL = Config.apiURL.appending(path: "users/shops/recent")
    let recentBookingService = AlamofireRecentBookingService(url: recentBookingURL, client: client)
    
    let viewModel = ShopListViewModel(recentBookingService: recentBookingService, shopListService: shopListService, onShopSelected: { _ in })
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
    // TODO
    let view = NotificationListView()
    return AnyView(view)
  }
  
  func makeUserMainTabPaymentSelectionView() -> AnyView {
    // TODO
    let view = PaymentMethodSelectionView()
    return AnyView(view)
  }
}
