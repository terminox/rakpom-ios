//
//  CustomTabBar.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

enum Tabs: Int {
  case prize = 0
  case q = 1
  case point = 2
  case noti = 3
  case payment = 4
}

struct CustomTabBar: View {
  
  @Binding var selectedTab: Tabs
  
  var body: some View {
    HStack {
      Button {
        selectedTab = .prize
      } label: {
        if selectedTab == .prize {
          TabBarButtonSelected(imageName: "Gift.fill", title: "ลุ้นรางวัล")
        } else {
          TabBarButton(imageName: "Gift", title: "ลุ้นรางวัล")
        }
      }
      
      Button {
        selectedTab = .q
      } label: {
        if selectedTab == .q {
          TabBarButtonSelected(imageName: "Q.fill", title: "จองคิว")
        } else {
          TabBarButton(imageName: "Q", title: "จองคิว")
        }
      }
      
      Button {
        selectedTab = .point
      } label: {
        if selectedTab == .point {
          TabBarButtonSelected(imageName: "Coin.fill", title: "สะสมแต้ม")
        } else {
          TabBarButton(imageName: "CoinIcon", title: "สะสมแต้ม")
        }
      }
      
      Button {
        selectedTab = .noti
      } label: {
        if selectedTab == .noti {
          TabBarButtonSelected(imageName: "Bell.fill", title: "แจ้งเตือน")
        } else {
          TabBarButton(imageName: "Bell", title: "แจ้งเตือน")
        }
      }
      
      Button {
        selectedTab = .payment
      } label: {
        if selectedTab == .payment {
          TabBarButtonSelected(imageName: "Wallet.fill", title: "การชำระเงิน")
        } else {
          TabBarButton(imageName: "Wallet", title: "การชำระเงิน")
        }
      }
    }
    .background(.white)
  }
}

#Preview {
  CustomTabBar(selectedTab: .constant(.prize))
}

struct TabBarButtonSelected: View {
  let imageName: String
  let title: String
  
  var body: some View {
//    GeometryReader { geo in
      VStack {
        Rectangle()
          .foregroundStyle(.blueButton)
          .frame(height: 2)
        
        Image("\(imageName)")
          .resizable()
          .scaledToFit()
          .frame(width: 35, height: 35)
        
        Text(title)
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.blueButton)
          .bold()
      }
//      .frame(width: geo.size.width)
//    }
  }
}

struct TabBarButton: View {
  let imageName: String
  let title: String
  
  var body: some View {
//    GeometryReader { geo in
      VStack {
        Rectangle()
          .foregroundStyle(.white)
          .frame(height: 2)
        
        Image("\(imageName)")
          .resizable()
          .scaledToFit()
          .frame(width: 35, height: 35)
        
        Text(title)
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.gray)
      }
//      .frame(width: geo.size.width)
//    }
  }
}
