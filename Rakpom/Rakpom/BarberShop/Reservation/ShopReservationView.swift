//
//  ReservationView.swift
//  Rakpom
//
//  Created by CatMeox on 20/6/2567 BE.
//

import SwiftUI

struct ShopReservationView: View {
  @State var autoReserve = true
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BarberHeaderView(id: "asdf")
        
        Toggle("รับจองคิวอัตโนมัติ", isOn: $autoReserve)
          .font(.custom("Noto Sans Thai", size: 18))
          .foregroundStyle(.black)
          .toggleStyle(SwitchToggleStyle(tint: .blueButton))
          .padding()
          .background(.white)
        
        ScrollView {
          VStack(spacing: 0) {
            HStack {
              Image("User")
                .resizable()
                .frame(width: 74, height: 74)
                .clipShape(Circle())
                .overlay(
                Circle()
                  .stroke(.halfGray)
                )
                .padding()
                .padding(.top, -40)
              
              VStack(alignment: .leading) {
                Text("กวิน ยินดี")
                  .fontWeight(.bold)
                
                HStack(spacing: 27) {
                  Text("วันที่จอง")
                  Text(":")
                  Text("12/09/2023")
                    .padding(.leading, -9)
                }
                
                HStack(spacing: 18) {
                  Text("เวลาที่จอง")
                  Text(":")
                  Text("12:00" + " น.")
                }
                
                HStack {
                  Button {
                    
                  } label: {
                    Text("ไม่รับจอง")
                      .font(.custom("Noto Sans Thai", size: 12))
                      .frame(width: 86, height: 32)
                      .foregroundStyle(.white)
                      .background(.black)
                      .clipShape(Capsule())
                }
                  
                  Button {
                    
                  } label: {
                    Text("รับจอง")
                      .font(.custom("Noto Sans Thai", size: 12))
                      .frame(width: 86, height: 32)
                      .foregroundStyle(.white)
                      .background(.blueButton)
                      .clipShape(Capsule())
                  }
                }
              }
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
              
              Spacer()
            }
            .padding(.leading, 25)
          }
          .frame(maxWidth: .infinity)
          .frame(height: 162)
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
  ShopReservationView()
}
