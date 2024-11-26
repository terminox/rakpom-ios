//
//  PointView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

struct PointView: View {
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        TitleView(title: "ประวัติการใช้บริการ", color: .white)
        
        ScrollView {
          HStack(spacing: 16) {
            Image("Barber4")
              .resizable()
              .frame(width: 100, height: 95)
              .clipShape(RoundedRectangle(cornerRadius: 4))
            
            VStack(alignment: .leading, spacing: 6) {
              Text("ร้านลุงหนุ่ม")
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundStyle(.black)
              
              Label("35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900", image: "Location")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundColor(.darkGray)
                .lineLimit(1)
              
              HStack {
                Text("การใช้บริการ    :")
                Text("  " + "ตัดผม")
              }
              .font(.custom("Noto Sans Thai", size: 12))
              .foregroundStyle(.black)
              
              HStack {
                Image("Coin")
                Text("สะสม " + "1" + " แต้ม")
              }
              .font(.custom("Noto Sans Thai", size: 11))
              .foregroundStyle(.black)
              .padding(4)
              .padding(.horizontal, 4)
              .background(.lightGray)
              .clipShape(Capsule())
              .padding(.top, 4)
            }
            
            VStack {
              Text("฿ " + "150")
                .font(.custom("Noto Sans Thai", size: 18))
                .foregroundStyle(.black)
                .fontWeight(.bold)
                .padding(.top, 8)
              
              Spacer()
            }
          }
          .padding()
          .frame(maxWidth: .infinity)
          .frame(height: 129)
          .background(.white)
          .padding(.top, 5)
          .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
  }
}

#Preview {
  PointView()
}
