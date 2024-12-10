//
//  RakpomViewFactory+ShopCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 30/11/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: ShopCoordinatorViewFactory {
  func makeShopDetailView(onReviewsPressed: @escaping () -> Void, onConfirmed: @escaping (BookingConfirmationDetailItem) -> Void) -> AnyView {
    // TODO
//    let view = ReservationView(id: "")
    let view = EmptyView()
    return AnyView(view)
  }
  
  func makeShopReviewListView(for shop: ShopItem) -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }
  
  func makeShopBookingConfirmationView(for detail: BookingConfirmationDetailItem) -> AnyView {
    // TODO
    let view = EmptyView()
    return AnyView(view)
  }
}
