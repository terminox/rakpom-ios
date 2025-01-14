//
//  CustomTabBar.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

// MARK: - Tabs

enum Tabs: Int {
  case prize = 0
  case reservation = 1
  case point = 2
  case noti = 3
  case payment = 4
}

// MARK: - CustomTabBar

struct CustomTabBar: View {

  @Binding var selectedTab: Tabs


  var body: some View {
    HStack {
      Button {
        selectedTab = .prize
      } label: {
        if selectedTab == .prize {
          TabBarButtonSelected(image: Image("Gift.fill"), title: "ลุ้นรางวัล")
        } else {
          TabBarButton(image: Image("Gift"), title: "ลุ้นรางวัล")
        }
      }

      Button {
        selectedTab = .reservation
      } label: {
        if selectedTab == .reservation {
          TabBarButtonSelected(image: Image("Q.fill"), title: "จองคิว")
        } else {
          TabBarButton(image: Image("Q"), title: "จองคิว")
        }
      }

      Button {
        selectedTab = .point
      } label: {
        if selectedTab == .point {
          TabBarButtonSelected(image: Image("Coin.fill"), title: "สะสมแต้ม")
        } else {
          TabBarButton(image: Image("CoinIcon"), title: "สะสมแต้ม")
        }
      }

      Button {
        selectedTab = .noti
      } label: {
        if selectedTab == .noti {
          TabBarButtonSelected(image: Image("Bell.fill"), title: "แจ้งเตือน")
        } else {
          TabBarButton(image: Image("Bell"), title: "แจ้งเตือน")
        }
      }

      Button {
        selectedTab = .payment
      } label: {
        if selectedTab == .payment {
          TabBarButtonSelected(image: Image("Wallet.fill"), title: "การชำระเงิน")
        } else {
          TabBarButton(image: Image("Wallet"), title: "การชำระเงิน")
        }
      }
    }
    .background(.white)
  }
}

#Preview {
  CustomTabBar(selectedTab: .constant(.prize))
}

// MARK: - TabBarButtonSelected

struct TabBarButtonSelected: View {

  let image: Image
  let title: String

  var body: some View {
//    GeometryReader { geo in
    VStack {
      Rectangle()
        .foregroundStyle(.blueButton)
        .frame(height: 2)

      image
        .resizable()
        .scaledToFit()
        .frame(width: 35, height: 35)
        .foregroundStyle(.blueButton)

      Text(title)
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.blueButton)
        .bold()
    }
//      .frame(width: geo.size.width)
//    }
  }
}

// MARK: - TabBarButton

struct TabBarButton: View {

  let image: Image
  let title: String

  var body: some View {
//    GeometryReader { geo in
    VStack {
      Rectangle()
        .foregroundStyle(.white)
        .frame(height: 2)

      image
        .resizable()
        .scaledToFit()
        .frame(width: 35, height: 35)
        .foregroundStyle(.gray)

      Text(title)
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.gray)
    }
//      .frame(width: geo.size.width)
//    }
  }
}
