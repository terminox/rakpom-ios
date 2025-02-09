//
//  ReviewCompletedView.swift
//  Rakpom
//
//  Created by CatMeox on 31/5/2567 BE.
//

import SwiftUI

struct ReviewCompletedView: View {
  var body: some View {
    VStack(spacing: 25) {
      Image("Thump")

      Text("ขอบคุณสำหรับการรีวิว")
        .font(.custom("Noto Sans Thai", size: 18))
        .foregroundStyle(.black)
        .fontWeight(.semibold)
      
      Button {
        // Back to Home scrreen
      } label: {
        AppButton(title: "กลับสู่หน้าหลัก")
          .padding(.horizontal)
      }
    }
    .frame(width: 308, height: 311)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 24))
  }
}

#Preview {
  ReviewCompletedView()
}
