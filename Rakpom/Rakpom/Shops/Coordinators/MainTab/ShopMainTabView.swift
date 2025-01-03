//
//  ShopMainTabView.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import SwiftUI

// MARK: - ShopMainTabView

struct ShopMainTabView: View {

  // MARK: Internal

  let factory: ShopMainTabViewFactory
  let onWithdrawHistoryPressed: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $selectedTab) {
        // Transactions
        factory.makeShopMainTabTransactionsView()
          .tag(BarberTabs.trans)

        // Bookings
        factory.makeShopMainTabPendingBookingsView()
          .tag(BarberTabs.barberQ)

        // Balance Account
        factory.makeShopMainTabBalanceAccountView(onWithdrawHistoryPressed: onWithdrawHistoryPressed)
          .tag(BarberTabs.acc)

        // Reviews
        factory.makeShopMainTabReviewsView()
          .tag(BarberTabs.review)
      }

      BarberCustomTabBar(selectedTab: $selectedTab)
    }
  }

  // MARK: Private

  @State private var selectedTab: BarberTabs = .trans
  
}

// MARK: - ShopMainTabViewFactory

protocol ShopMainTabViewFactory {
  func makeShopMainTabTransactionsView() -> AnyView

  func makeShopMainTabPendingBookingsView() -> AnyView

  func makeShopMainTabBalanceAccountView(onWithdrawHistoryPressed: @escaping () -> Void) -> AnyView

  func makeShopMainTabReviewsView() -> AnyView
}
