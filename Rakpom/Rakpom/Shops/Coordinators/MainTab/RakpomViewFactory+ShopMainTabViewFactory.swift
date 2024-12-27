//
//  RakpomViewFactory+ShopMainTabViewFactory.swift
//  Rakpom
//
//  Created by yossa on 19/12/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: ShopMainTabViewFactory {
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

  func makeShopMainTabBalanceAccountView(onWithdrawHistoryPressed _: @escaping () -> Void) -> AnyView {
//    let viewModel = BalanceAccountViewModel(balanceAccountItemListFetchingService: <#T##any BalanceAccountItemListFetchingService#>, withdrawRequestService: <#T##any ShopWithdrawRequestService#>)
    let view = EmptyView()
    return AnyView(view)
  }

  func makeShopMainTabReviewsView() -> AnyView {
    let url = Config.apiURL.appending(path: "shops/reviews")
    let service = AlamofireShopReviewListService(endpointURL: url, tokenManager: tokenManager)
    let viewModel = ReviewListViewModel(service: service)
    let view = ReviewListView(viewModel: viewModel)
    return AnyView(view)
  }
}
