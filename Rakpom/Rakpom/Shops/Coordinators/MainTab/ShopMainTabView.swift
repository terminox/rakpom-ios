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
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .trans ? Image("Gift.fill") : Image("Gift")

              Text("ข้อมูลการใช้")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(BarberTabs.trans)

        // Bookings
        factory.makeShopMainTabPendingBookingsView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .barberQ ? Image("Q.fill") : Image("Q")

              Text("รับจองคิว")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(BarberTabs.barberQ)

        // Balance Account
        factory.makeShopMainTabBalanceAccountView(onWithdrawHistoryPressed: onWithdrawHistoryPressed)
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .barberNoti ? Image("Coin.fill") : Image("CoinIcon")

              Text("บัญชีของคุณ")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(BarberTabs.barberNoti)

        // Reviews
        factory.makeShopMainTabReviewsView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .review ? Image("Wallet.fill") : Image("Wallet")

              Text("การชำระเงิน")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
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
