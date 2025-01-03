//
//  BarberCustomTabBar.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

enum BarberTabs: Int {
  case trans = 0
  case barberQ = 1
  case barberNoti = 2
  case acc = 3
  case review = 4
}

struct BarberCustomTabBar: View {
  
  @Binding var selectedTab: BarberTabs
  
  var body: some View {
    HStack {
      Button {
        selectedTab = .trans
      } label: {
        if selectedTab == .trans {
          TabBarButtonSelected(imageName: "Shop.fill", title: "ข้อมูลการใช้")
        } else {
          TabBarButton(imageName: "Shop", title: "ข้อมูลการใช้")
        }
      }
      
      Button {
        selectedTab = .barberQ
      } label: {
        if selectedTab == .barberQ {
          TabBarButtonSelected(imageName: "Q.fill", title: "รับจองคิว")
        } else {
          TabBarButton(imageName: "Q", title: "รับจองคิว")
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
          TabBarButtonSelected(imageName: "WalletShop.fill", title: "บัญชีของคุณ")
        } else {
          TabBarButton(imageName: "WalletShop", title: "บัญชีของคุณ")
        }
      }
      
      Button {
        selectedTab = .review
      } label: {
        if selectedTab == .review {
          TabBarButtonSelected(imageName: "Comment.fill", title: "รีวิวร้าน")
        } else {
          TabBarButton(imageName: "Comment", title: "รีวิวร้าน")
        }
      }
    }
  }
}

#Preview {
  BarberCustomTabBar(selectedTab: .constant(.trans))
}
