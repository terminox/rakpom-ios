//
//  BarberNotiView.swift
//  Rakpom
//
//  Created by CatMeox on 21/6/2567 BE.
//

import SwiftUI

struct BarberNotiView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BarberHeaderView()
        
        Image("MobilePayment")
          .padding(.top, 48)
        
        Text("ข้อมูลการชำระ")
          .font(.custom("Noto Sans Thai", size: 20))
          .fontWeight(.bold)
          .foregroundStyle(.black)
          .padding()
        
        VStack(alignment: .leading, spacing: 12) {
          HStack(spacing: 26) {
            Text("บริการด้าน")
            Text(":")
              .padding(.leading, 13)
            Text("ตัดผม")
          }
          
          HStack(spacing: 26) {
            Text("ชำระเงินด้วย")
            Text(":")
            Text("แต้มสะสม")
          }
          
          HStack(spacing: 26) {
            Text("จำนวนเงิน")
            Text(":")
              .padding(.leading, 15)
            Text("100.00")
          }
        }
        .font(.custom("Noto Sans Thai", size: 18))
        .foregroundStyle(.black)
        
        HStack {
          Text("รหัสร้านค้าที่ใช้บริการ")
          Text(":")
          Text("98485672")
        }
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundColor(.gray)
        .padding(.top, 25)
        
        HStack {
          Text("ชื่อลูกค้า")
          Text(":")
          Text("อภิเดช ยิ้มเก่ง")
        }
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundColor(.gray)
        .padding(.top, 4)
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  BarberNotiView()
}
