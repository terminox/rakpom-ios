//
//  HomeView.swift
//  Rakpom
//
//  Created by CatMeox on 2/6/2567 BE.
//

import SwiftUI

struct SettingsScreen: Hashable {
  let id: String
}

struct HomeView: View {
  let id: String
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        HStack {
          HStack {
            Button {
              dismiss()
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }

            Image("User")
              .resizable()
              .frame(width: 53, height: 53)
              .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
              .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
            
            VStack(spacing: 4) {
              Text("สวัสดี! " + "คุณอภิเดช")
                .font(.custom("Noto Sans Thai", size: 18))
              Button {
                // Navigate to point screen
              } label: {
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
            .foregroundColor(Color("Black"))
          }
          
          Spacer()
          
          NavigationLink(value: AnyHashable(SettingsScreen(id: id))) {
            Image(systemName: "gearshape")
              .resizable()
              .frame(width: 28, height: 28)
              .foregroundColor(Color("Black"))
              .frame(width: 42, height: 42)
          }
        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 133)
        
        Spacer()
        
        Image("Home10free1")
          .resizable()
          .frame(maxWidth: .infinity)
          .frame(height: geo.size.height * 0.78)
      }
    }
    .background(.blueHome)
    .ignoresSafeArea()
  }
}

#Preview {
  HomeView(id: "qwerty")
}
