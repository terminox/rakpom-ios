//
//  UserHeaderView.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import SwiftUI

struct ShopHeaderView: View {
  
  let shop: AppScaffoldShop?
  let onSettingsPressed: () -> Void
  
  var body: some View {
    HStack {
      if let shop = shop {
        HStack(spacing: 16) {
          AsyncImage(url: shop.avatarURL) { image in
            image
              .resizable()
              .frame(width: 53, height: 53)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
          } placeholder: {
            Image(.barber1)
              .resizable()
              .frame(width: 53, height: 53)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
          }
          
          VStack(alignment: .leading, spacing: 4) {
            Text("สวัสดี! \(shop.name)")
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)
            
            Text("รหัสร้านค้า : \(shop.shopCode)")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundColor(.gray)
          }
        }
      } else {
        ProgressView()
          .progressViewStyle(.circular)
      }
      
      Spacer()
      
      HStack(alignment: .center, spacing: 0) {
        Button(action: onSettingsPressed) {
          Image(systemName: "house")
            .resizable()
            .frame(width: 25, height: 22)
            .foregroundColor(Color("Black"))
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.7))
            .clipShape(Circle())
        }
        .padding(.top, -8)
        
        Image(.logo)
      }
    }
    .padding()
//    .padding(.top, 40)
    .frame(maxWidth: .infinity)
//    .frame(height: 133)
    .background(.blueApp)
  }
}

#Preview {
  let shop = AppScaffoldShop(name: "ยศภาส", avatarURL: URL(string: "https://unsplash.com/photos/grayscale-photo-of-man-c_GmwfHBDzk")!, shopCode: "123456")
  ShopHeaderView(shop: shop, onSettingsPressed: {})
}

#Preview {
  ShopHeaderView(shop: nil, onSettingsPressed: {})
}
