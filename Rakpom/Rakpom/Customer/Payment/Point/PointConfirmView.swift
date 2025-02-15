//
//  PointConfirmView.swift
//  Rakpom
//
//  Created by CatMeox on 30/5/2567 BE.
//

import SwiftUI

struct PointConfirmView: View {
  @State var point: Int = 1
  @State var shopID: String = ""
  
  let type: String
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BackHeaderView(title: "การชำระ", id: "qwerty")
        
        TitleView(title: "ชำระด้วยแต้มสะสม", color: .lightGray)
        
        Image("Treasure")
        
        if point == 10 {
          VStack(spacing: 0) {
            VStack {
              Text("ตอนนี้คุณมีแต้มสะสมครบ 10 แต้ม")
              Text("ต้องการแลกสิทธิ์การตัดผมฟรีใช่หรือไม่")
            }
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding(.bottom, 36)
            
            VStack(alignment: .leading, spacing: 8) {
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
            .padding(.horizontal, 72)
            
            Button {
              
            } label: {
              AppButton(title: "ยืนยัน")
                .padding(32)
            }
          }
        } else {
          VStack {
            Text("ตอนนี้คุณมีแต้มสะสม \(point) แต้ม")
              .padding(.bottom, 8)
            Text("คุณสามารถแลกสิทธิ์การตัดผมฟรีได้")
            Text("เมื่อสะสมครบ 10 แต้ม")
          }
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)

        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  PointConfirmView(type: "Point")
}
