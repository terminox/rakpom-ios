//
//  CustomerMainTabView.swift
//  Rakpom
//
//  Created by CatMeox on 10/6/2567 BE.
//

import SwiftUI
import UIKit

struct CustomerMainTabView: View {
  
  init() {
  UITabBar.appearance().backgroundColor = UIColor.white
  }
  
  @State private var selection = 0
  
  var body: some View {
    TabView(selection: $selection) {
      Group {
        MonthlyWinPrizeView()
          .tabItem {
            VStack(spacing: 4) {
              selection == 0 ? Image("Gift.fill") : Image("Gift")
              
              Text("ลุ้นรางวัล")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
//          .tag(0)
        
        HistoryView()
          .tabItem {
            VStack(spacing: 4) {
              selection == 1 ? Image("Q.fill") : Image("Q")
              
              Text("จองคิว")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(1)
        
        PointView()
          .tabItem {
            VStack(spacing: 4) {
              selection == 2 ? Image("Coin.fill") : Image("CoinIcon")
              
              Text("สะสมแต้ม")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(2)
        
        NotificationView()
          .tabItem {
            VStack(spacing: 4) {
              selection == 3 ? Image("Bell.fill") : Image("Bell")

              Text("แจ้งเตือน")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(3)
        
        PaymentSelectionView()
          .tabItem {
            VStack(spacing: 4) {
              selection == 4 ? Image("Wallet.fill") : Image("Wallet")
            
              Text("การชำระเงิน")
                .font(.custom("Noto Sans Thai", size: 10))
            }
          }
          .tag(4)
      }
      .accentColor(.blueButton)
      .toolbar(.visible, for: .tabBar)
      .toolbarBackground(Color.white, for: .tabBar)
    }
  }
}

#Preview {
  CustomerMainTabView()
}
