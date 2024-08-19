//
//  RootView.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

struct CustomerMainTabView: View {
  @State var selectedTab: Tabs = .prize
  
  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $selectedTab) {
        Group {
          MonthlyWinPrizeView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .prize ? Image("Gift.fill") : Image("Gift")
                
                Text("ลุ้นรางวัล")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(Tabs.prize)
          
          HistoryView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .q ? Image("Q.fill") : Image("Q")
                
                Text("จองคิว")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(Tabs.q)
          
          PointView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .point ? Image("Coin.fill") : Image("CoinIcon")
                
                Text("สะสมแต้ม")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(Tabs.point)
          
          NotificationView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .noti ? Image("Bell.fill") : Image("Bell")

                Text("แจ้งเตือน")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(Tabs.noti)
          
          PaymentSelectionView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .payment ? Image("Wallet.fill") : Image("Wallet")
              
                Text("การชำระเงิน")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(Tabs.payment)
        }
        .accentColor(.blueButton)
        .toolbarBackground(Color.white, for: .tabBar)
        .toolbar(.hidden, for: .tabBar)
      }
      
      CustomTabBar(selectedTab: $selectedTab)
    }
  }
}

#Preview {
  CustomerMainTabView()
}
