//
//  MyAccountView.swift
//  Rakpom
//
//  Created by CatMeox on 24/6/2567 BE.
//

import SwiftUI

struct MyAccountView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BarberHeaderView()
        
        TitleView(title: "บัญชีของคุณ", color: .lightGray)
        
        VStack(spacing: 0) {
          HStack {
            Text("ยอดในระบบ")
              .foregroundStyle(.black)
            
            Spacer()
            
            Text("120")
              .bold()
              .foregroundStyle(.black)
          }
          .padding()
          
          Divider()
          
          ListData(title: "ยอดชำระสแกนจ่าย", number: "+ " + "100", color: .green)
          
          ListData(title: "ยอดชำระเงินสด", number: "- " + "20", color: .red)
          
          ListData(title: "ยอดคอมมิสชั่น", number: "10%", color: .black)
          
          ListData(title: "ภาษีมูลค่าเพิ่ม", number: "7%", color: .black)
          
          ListData(title: "ยอดที่ถอนได้", number: "0", color: .red)
            .bold()
            .foregroundColor(.red)

        }
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundStyle(.black)
        
        Button {
          
        } label: {
          AppButton(title: "ถอนเงิน")
        }
        .padding(.horizontal, 36)
        .padding(.top, 27)
        
        Button {
          
        } label: {
          Text("ดูประวัติการถอนเงิน")
            .foregroundColor(.blueButton)
            .font(.custom("Noto Sans Thai", size: 16))
            .underline()
            .padding()
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

struct ListData: View {
  let title: String
  let number: String
  let color: Color
  
  var body: some View {
    HStack {
      Text(title)
      
      Spacer()
      
      Text(number)
        .foregroundColor(color)
    }
    .padding()
    
    Divider()
  }
}

#Preview {
  MyAccountView()
}
