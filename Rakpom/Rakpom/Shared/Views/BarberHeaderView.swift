//
//  BarberHeaderView.swift
//  Rakpom
//
//  Created by CatMeox on 19/6/2567 BE.
//

import SwiftUI

struct BarberHomeScreen: Hashable {
  let id: String
}

struct BarberHeaderView: View {
  let id: String
  
  var body: some View {
    HStack {
      HStack(spacing: 16) {
        Image("Barber2")
          .resizable()
          .frame(width: 53, height: 53)
          .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
          .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
        
        VStack(alignment: .leading, spacing: 4) {
          Text("สวัสดี! " + "ร้าน" + "ลุงหนุ่ม")
            .font(.custom("Noto Sans Thai", size: 18))
            .foregroundStyle(.black)
          
          Text("รหัสร้านค้า : " + "276548")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundColor(.gray)
        }
      }
      
      Spacer()
      
      HStack(alignment: .center, spacing: 0) {
        NavigationLink(value: AnyHashable(BarberHomeScreen(id: id))) {
          Image(systemName: "house")
            .resizable()
            .frame(width: 25, height: 22)
            .foregroundColor(Color("Black"))
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.7))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .padding(.top, -8)
        
        Image("Logo")
      }
    }
    .padding()
    .padding(.top, 40)
    .frame(maxWidth: .infinity)
    .frame(height: 133)
    .background(.blueApp)    }
}

#Preview {
  BarberHeaderView(id: "asdf")
}
