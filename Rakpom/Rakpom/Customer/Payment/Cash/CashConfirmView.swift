//
//  CashConfirmView.swift
//  Rakpom
//
//  Created by CatMeox on 30/5/2567 BE.
//

import SwiftUI

struct CashConfirmView: View {
  @State var price: String = ""
  @State var shopID: String = ""
  
  let type: String
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BackHeaderView(title: "การชำระ", id: "qwerty")
        
        TitleView(title: "ชำระด้วยเงินสด", color: .lightGray)
        
        ZStack {
          Image("Bluelabel")
          Image("CashPayment")
        }
        .padding(27)
        
        VStack(alignment: .leading, spacing: 8) {
          Text("ค่าบริการจำนวนเงิน")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          
          TextField("", text: $price)
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.blueButton)
            )
            .padding(.bottom, 8)
          
          Text("รหัสร้านค้า")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)
          
          TextField("", text: $shopID)
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.blueButton)
            )
        }
        .padding(.horizontal, 32)
        
        Button {
          
        } label: {
          AppButton(title: "ยืนยัน")
            .padding(32)
        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  CashConfirmView(type: "Cash")
}
