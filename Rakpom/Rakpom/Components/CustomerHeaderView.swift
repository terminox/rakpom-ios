//
//  HeaderView.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI

struct HomeScreen: Hashable {
  let id: String
}

struct PointScreen: Hashable {
  let id: String
}

struct CustomerHeaderView: View {
  let id: String
  
  var body: some View {
        HStack {
          HStack {
            Image("User")
              .resizable()
              .frame(width: 53, height: 53)
              .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
              .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
            
            VStack(spacing: 4) {
              Text("สวัสดี! " + "คุณอภิเดช")
                .font(.custom("Noto Sans Thai", size: 18))
              
              NavigationLink(value: AnyHashable(PointScreen(id: id))) {
                HStack(spacing: 4) {
                  Image("Coin")
                  Text("คุณมี " + "1" + " แต้ม")
                    .font(.custom("Noto Sans Thai", size: 16))
                }
              }
              .padding(.vertical, 2)
              .padding(.horizontal, 8)
              .background(Color.white)
              .clipShape(Capsule())
            }
            .foregroundStyle(.black)
          }
          
          Spacer()
          
          HStack(alignment: .center, spacing: 0) {
            NavigationLink(value: AnyHashable(HomeScreen(id: id))) {
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
        .background(.blueApp)
  }
}

#Preview {
  CustomerHeaderView(id: "qwerty")
}
