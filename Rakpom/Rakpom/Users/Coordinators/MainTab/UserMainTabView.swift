//
//  UserMainTabView.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import SwiftUI

// MARK: - UserMainTabView

struct UserMainTabView: View {

  // MARK: Internal

  let factory: UserMainTabViewFactory

  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $selectedTab) {
        factory.makeUserMainTabPrizeListView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .prize ? Image("Gift.fill") : Image("Gift")

              Text("ลุ้นรางวัล")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(Tabs.prize)

        factory.makeUserMainTabShopListView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .reservation ? Image("Q.fill") : Image("Q")

              Text("จองคิว")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(Tabs.reservation)

        factory.makeUserMainTabBookingHistoryView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .point ? Image("Coin.fill") : Image("CoinIcon")

              Text("สะสมแต้ม")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(Tabs.point)

        factory.makeUserMainTabNotificationListView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .noti ? Image("Bell.fill") : Image("Bell")

              Text("แจ้งเตือน")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(Tabs.noti)

        factory.makeUserMainTabPaymentSelectionView()
          .tabItem {
            VStack(spacing: 4) {
              selectedTab == .payment ? Image("Wallet.fill") : Image("Wallet")

              Text("การชำระเงิน")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(Tabs.payment)
      }

      CustomTabBar(selectedTab: $selectedTab)
    }
  }

  // MARK: Private

  @State private var selectedTab: Tabs = .reservation

}

// MARK: - UserMainTabViewFactory

protocol UserMainTabViewFactory {
  func makeUserMainTabPrizeListView() -> AnyView
  func makeUserMainTabShopListView() -> AnyView
  func makeUserMainTabBookingHistoryView() -> AnyView
  func makeUserMainTabNotificationListView() -> AnyView
  func makeUserMainTabPaymentSelectionView() -> AnyView
}
