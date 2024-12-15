//
//  CashDetailView.swift
//  Rakpom
//
//  Created by CatMeox on 20/6/2567 BE.
//

import SwiftUI

struct CashDetailView: View {
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        BackHeaderView(title: "รายละเอียด", id: "qwerty")
        
        ZStack {
          Image("Bluelabel")
            .resizable()
            .frame(width: 200, height: 200)
          Image("CashPayment")
            .resizable()
            .frame(width: 200, height: 200)
        }
        .padding(40)
        
        VStack(alignment: .leading) {
          HStack {
            Text("รับโอนจาก " + "กวิน ยินดี")
              .font(.custom("Noto Sans Thai", size: 14))
              .fontWeight(.bold)
              .foregroundStyle(.black)
            
            Spacer()
            
            Text("12/09/2023")
              .font(.custom("Noto Sans Thai", size: 10))
              .foregroundColor(.blueButton)
          }
          .padding(.bottom, 2)
          
          HStack {
            Text("บริการด้าน")
            Text("ร้านตัดผม")
          }
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.black)
          
          HStack {
            Text("ชำระด้วย   ")
            Text("เงินสด")
          }
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.black)
          
          HStack {
            Text("จำนวนเงิน ")
            Text("150.00" + " บาท")
          }
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.black)
        }
        .padding()
        .background(.white)
        .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(.halfGray)
          .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 3)
        )
        .padding(.horizontal, 32)
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  CashDetailView()
}
