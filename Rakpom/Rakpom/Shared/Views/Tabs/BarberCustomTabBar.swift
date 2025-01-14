//
//  BarberCustomTabBar.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

enum BarberTabs: Int {
  case home
  case trans
  case barberQ
  case acc
  case review
}

struct BarberCustomTabBar: View {
  
  @Binding var selectedTab: BarberTabs
  
  var body: some View {
    HStack {
      Button {
        selectedTab = .home
      } label: {
        if selectedTab == .home {
          TabBarButtonSelected(image: Image(systemName: "house.fill"), title: "ร้านค้า")
        } else {
          TabBarButton(image: Image(systemName: "house"), title: "ร้านค้า")
        }
      }
      
      Button {
        selectedTab = .trans
      } label: {
        if selectedTab == .trans {
          TabBarButtonSelected(image: Image("Shop.fill"), title: "ข้อมูลการใช้")
        } else {
          TabBarButton(image: Image("Shop"), title: "ข้อมูลการใช้")
        }
      }
      
      Button {
        selectedTab = .barberQ
      } label: {
        if selectedTab == .barberQ {
          TabBarButtonSelected(image: Image("Q.fill"), title: "รับจองคิว")
        } else {
          TabBarButton(image: Image("Q"), title: "รับจองคิว")
        }
      }
      
//      Button {
//        selectedTab = .barberNoti
//      } label: {
//        if selectedTab == .barberNoti {
//          TabBarButtonSelected(imageName: "Bell.fill", title: "แจ้งเตือน")
//        } else {
//          TabBarButton(imageName: "Bell", title: "แจ้งเตือน")
//        }
//      }
      
      Button {
        selectedTab = .acc
      } label: {
        if selectedTab == .acc {
          TabBarButtonSelected(image: Image("WalletShop.fill"), title: "บัญชีของคุณ")
        } else {
          TabBarButton(image: Image("WalletShop"), title: "บัญชีของคุณ")
        }
      }
      
      Button {
        selectedTab = .review
      } label: {
        if selectedTab == .review {
          TabBarButtonSelected(image: Image("WalletShop"), title: "รีวิวร้าน")
        } else {
          TabBarButton(image: Image("Comment"), title: "รีวิวร้าน")
        }
      }
    }
  }
}

#Preview {
  BarberCustomTabBar(selectedTab: .constant(.trans))
}
