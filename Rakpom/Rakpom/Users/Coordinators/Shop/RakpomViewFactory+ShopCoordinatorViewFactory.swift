//
//  RakpomViewFactory+ShopCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 30/11/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: ShopCoordinatorViewFactory {
  func makeShopDetailView(
    for shop: ShopItem,
    onReviewsPressed: @escaping () -> Void,
    onConfirmed: @escaping ([BookingConfirmationDetailItem]) -> Void)
    -> AnyView
  {
    let url = Config.apiURL
    let shopDetailService = AlamofireShopDetailService(id: shop.id, baseURL: url, tokenManager: tokenManager)
    let bookingRequestCreationService = AlamofireBookingRequestCreatingService(
      shopID: shop.id,
      baseURL: url,
      tokenManager: tokenManager)
    let viewModel = ShopDetailViewModel(
      shopDetailService: shopDetailService,
      bookingRequestCreatingService: bookingRequestCreationService,
      onReviewsPressed: onReviewsPressed,
      onConfirmed: onConfirmed)
    let view = BackScaffold(title: "จองคิว") {
      ShopDetailView(viewModel: viewModel)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeShopReviewListView(for shop: ShopItem) -> AnyView {
    let url = Config.apiURL.appending(path: "users/shops/\(shop.id)/reviews")
    let service = AlamofireShopReviewListService(endpointURL: url, tokenManager: tokenManager)
    let viewModel = ReviewListViewModel(service: service)
    let view = BackScaffold(title: "คะแนน") {
      ReviewListView(viewModel: viewModel)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makeShopBookingConfirmationView(for items: [BookingConfirmationDetailItem], onConfirmed: @escaping () -> Void) -> AnyView {
    let view = BookingConfirmationView(items: items, onConfirmed: onConfirmed)
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }
}
