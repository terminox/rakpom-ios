//
//  DetailView.swift
//  Rakpom
//
//  Created by CatMeox on 20/6/2567 BE.
//

import SwiftUI

struct TransferDetailView: View {

  var body: some View {
    GeometryReader { geo in
      VStack {
        BackHeaderView(title: "รายละเอียด", id: "qwerty")
        
        VStack {
          Image(systemName: "photo")
            .font(.title)
            .foregroundColor(.halfGray)
          
          Text("รูปสลิป")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundColor(.gray)
        }
        .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.35)
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        
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
            Text("การโอน")
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
  TransferDetailView()
}
