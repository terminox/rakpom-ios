//
//  ShopCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 27/12/2567 BE.
//

import SwiftUI

protocol ShopCoordinatorViewFactory {
  func makeShopDetailView(
    for shop: ShopItem,
    onReviewsPressed: @escaping () -> Void,
    onConfirmed: @escaping ([BookingConfirmationDetailItem]) -> Void)
    -> AnyView
  
  func makeShopReviewListView(for shop: ShopItem) -> AnyView
  
  func makeShopBookingConfirmationView(
    for items: [BookingConfirmationDetailItem],
    onConfirmed: @escaping () -> Void)
    -> AnyView
}
