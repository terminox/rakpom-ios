//
//  YourPointView.swift
//  Rakpom
//
//  Created by CatMeox on 31/5/2567 BE.
//

import SwiftUI

struct YourPointView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BackHeaderView(title: "แต้มของคุณ", id: "qwerty")
        
        HStack(spacing: 4) {
          Image("Coin")
            .resizable()
            .frame(width: 26, height: 26)
          
          Text("1" + " แต้ม")
            .font(.custom("Noto Sans Thai", size: 30))
            .fontWeight(.bold)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
        }
        .frame(width: geo.size.width * 0.5, height: 54)
        .background(Color.white)
        .clipShape(Capsule())
        .foregroundColor(Color("Black"))
        .frame(maxWidth: .infinity)
        .padding(.bottom, 32)
        .background(.blueApp)
        
        HStack {
          Image("User")
            .resizable()
            .frame(width: 53, height: 53)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(Circle().stroke(Color.blueBG, lineWidth: 2.5))
          
          VStack(alignment: .leading) {
            Text("สวัสดี! " + "คุณอภิเดช")
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)
            
            Text("รหัสสมาชิก :" + " " + "123456")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.gray)
          }
          
          Spacer()
        }
        .padding(24)
        
        Divider()
        
        HStack {
          Image("Coin")
            .resizable()
            .frame(width: 26, height: 26)
          
          Text("1 แต้ม")
            .font(.custom("Noto Sans Thai", size: 15))
            .foregroundStyle(.black)
          
          Spacer()
          
          Text("รหัสร้าน")
            .font(.custom("Noto Sans Thai", size: 15))
            .foregroundStyle(.black)
          
          Text("183922")
            .font(.custom("Noto Sans Thai", size: 15))
            .foregroundStyle(.blueButton)
            .padding(.trailing, 40)
        }
        .padding(.horizontal, 30)
        .padding()
        
        Divider()
        
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  YourPointView()
}
