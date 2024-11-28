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
    // TODO
    let view = PointView()
    return AnyView(view)
  }
  
  func makeUserMainTabNotificationListView() -> AnyView {
    // TODO
    let view = NotificationView()
    return AnyView(view)
  }
  
  func makeUserMainTabPaymentSelectionView() -> AnyView {
    // TODO
    let view = PaymentSelectionView()
    return AnyView(view)
  }
}
