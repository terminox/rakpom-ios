//
//  MonthlyWinPrizeView.swift
//  Rakpom
//
//  Created by CatMeox on 2/6/2567 BE.
//

import SwiftUI

struct MonthlyWinPrizeView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
//        BackHeaderView(title: "ตู้เซฟของคุณ")
//        
//        HStack(spacing: 4) {
//          Image("Coin")
//            .resizable()
//            .frame(width: 26, height: 26)
//          
//          Text("1" + " แต้ม")
//            .font(.custom("Noto Sans Thai", size: 30))
//            .fontWeight(.bold)
//            .padding(.vertical, 2)
//            .padding(.horizontal, 8)
//        }
//        .frame(width: geo.size.width * 0.5, height: 54)
//        .background(Color.white)
//        .clipShape(Capsule())
//        .foregroundStyle(.black)
//        .frame(maxWidth: .infinity)
//        .padding(.bottom, 32)
//        .background(.blueApp)
//        
//        HStack {
//          Image("User")
//            .resizable()
//            .frame(width: 53, height: 53)
//            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//            .overlay(Circle().stroke(Color.blueBG, lineWidth: 2.5))
//          
//          VStack(alignment: .leading) {
//            Text("สวัสดี! " + "คุณอภิเดช")
//              .font(.custom("Noto Sans Thai", size: 18)).foregroundStyle(.black)
//            
//            Text("รหัสสมาชิก :" + " " + "123456")
//              .font(.custom("Noto Sans Thai", size: 14))
//              .foregroundStyle(.gray)
//          }
//          
//          Spacer()
//        }
//        .padding(24)
//        
//        Divider()
        CustomerHeaderView(id: "qwerty")
        
        VStack(spacing: 8) {
          Text("รหัสงวดวันที่ " + "20 ม.ค. 66")
            .font(.custom("Noto Sans Thai", size: 20))
            .fontWeight(.semibold)
            .foregroundStyle(.black)
          
          Text("211")
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .tracking(8)
            .frame(width: geo.size.width * 0.5, height: 42, alignment: .center)
            .background(.blueBG)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        .padding(.horizontal, 30)
        .padding(30)
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  MonthlyWinPrizeView()
}
