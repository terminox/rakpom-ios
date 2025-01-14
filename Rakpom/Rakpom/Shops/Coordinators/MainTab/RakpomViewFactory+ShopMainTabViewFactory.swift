//
//  RakpomViewFactory+ShopMainTabViewFactory.swift
//  Rakpom
//
//  Created by yossa on 19/12/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: ShopMainTabViewFactory {
  func makeShopMainTabHome() -> AnyView {
    let url = Config.apiURL.appending(path: "shops/profiles/me")
    let service = AlamofireShopHomeService(url: url, client: client)
    let viewModel = ShopHomeViewModel(service: service)
    let view = ShopHomeView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeShopMainTabTransactionsView() -> AnyView {
    let service = AlamofireTransactionListService(baseURL: Config.apiURL, tokenManager: tokenManager)
    let viewModel = TransactionListViewModel(service: service)
    let view = TransactionListView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeShopMainTabPendingBookingsView() -> AnyView {
    let fetchingService = AlamofirePendingBookingListFetchingService(baseURL: Config.apiURL, tokenManager: tokenManager)
    let acceptBookingService = AlamofireAcceptBookingService(baseURL: Config.apiURL, tokenManager: tokenManager)
    let rejectBookingService = AlamofireRejectBookingService(baseURL: Config.apiURL, tokenManager: tokenManager)
    let viewModel = BookingListViewModel(
      fetchingService: fetchingService,
      acceptBookingService: acceptBookingService,
      rejectBookingService: rejectBookingService)
    let view = BookingListView(viewModel: viewModel)
    return AnyView(view)
  }

  func makeShopMainTabBalanceAccountView(onWithdrawHistoryPressed: @escaping () -> Void) -> AnyView {
    let balanceAccountItemListFetchingService = AlamofireBalanceAccountItemListFetchingService(
      baseURL: Config.apiURL,
      tokenManager: tokenManager)
    let withdrawRequestService = AlamofireWithdrawRequestService(endpointURL: Config.apiURL, tokenManager: tokenManager)
    let viewModel = BalanceAccountViewModel(
      balanceAccountItemListFetchingService: balanceAccountItemListFetchingService,
      withdrawRequestService: withdrawRequestService)
    let view = BalanceAccountView(
      viewModel: viewModel,
      onWithdrawHistoryPressed: onWithdrawHistoryPressed)
    return AnyView(view)
  }

  func makeShopMainTabReviewsView() -> AnyView {
    let url = Config.apiURL.appending(path: "shops/reviews")
    let service = AlamofireShopReviewListService(endpointURL: url, tokenManager: tokenManager)
    let viewModel = ReviewListViewModel(service: service)
    let view = VStack(spacing: 0) {
      TitleView(title: "รีวิวร้าน", color: .white)
      ReviewListView(viewModel: viewModel)
    }
    return AnyView(view)
  }
}
