//
//  PaymentCompletionView.swift
//  Rakpom
//
//  Created by CatMeox on 31/5/2567 BE.
//

import SwiftUI

struct PaymentCompletionView: View {
  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "checkmark.circle.fill")
        .resizable()
        .frame(width: 70, height: 70)
        .foregroundStyle(.black)
      
      Text("ชำระเงินสำเร็จ")
        .font(.custom("Noto Sans Thai", size: 18))
        .foregroundStyle(.black)
        .fontWeight(.bold)
        .padding(.bottom)
      
      Button {
        // Navigate to write a review
      } label: {
        AppButton(title: "เขียนรีวิว")
          .padding(.horizontal)
      }
      
      Button {
        // Back to home screen
      } label: {
        Text("กลับสู่หน้าหลัก")
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.blueButton)
          .frame(maxWidth: .infinity)
          .frame(height: 47)
          .background(.white)
          .clipShape(Capsule())
          .overlay(
          RoundedRectangle(cornerRadius: 50)
            .stroke(Color("BlueButton"))
          )
          .padding(.horizontal)
      }
    }
    .frame(width: 308, height: 354)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 24))
  }
}

#Preview {
  PaymentCompletionView()
}
