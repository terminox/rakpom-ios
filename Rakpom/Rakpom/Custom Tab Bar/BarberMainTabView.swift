//
//  BarberMainTabView.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

struct BarberMainTabView: View {
  
  @State var selectedTab: BarberTabs = .trans
  
  var body: some View {
    VStack(spacing: 0) {
      TabView(selection: $selectedTab) {
        Group {
//          TransectionView(transitionType: "Scan")
          TransactionView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .trans ? Image("Gift.fill") : Image("Gift")
                
                Text("ลุ้นรางวัล")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(BarberTabs.trans)
          
          ShopReservationView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .barberQ ? Image("Q.fill") : Image("Q")
                
                Text("จองคิว")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(BarberTabs.barberQ)
          
          BarberNotiView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .barberNoti ? Image("Coin.fill") : Image("CoinIcon")
                
                Text("สะสมแต้ม")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(BarberTabs.barberNoti)
          
          MyAccountView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .acc ? Image("Bell.fill") : Image("Bell")

                Text("แจ้งเตือน")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(BarberTabs.acc)
          
          BarberReviewView()
            .tabItem {
              VStack(spacing: 4) {
                selectedTab == .review ? Image("Wallet.fill") : Image("Wallet")
              
                Text("การชำระเงิน")
                  .font(.custom("Noto Sans Thai", size: 10))
              }
            }
            .tag(BarberTabs.review)
        }
        .accentColor(.blueButton)
        .toolbarBackground(Color.white, for: .tabBar)
        .toolbar(.hidden, for: .tabBar)
      }
    
    Spacer()
    
    BarberCustomTabBar(selectedTab: $selectedTab)
    }
  }
}

#Preview {
  BarberMainTabView()
}
