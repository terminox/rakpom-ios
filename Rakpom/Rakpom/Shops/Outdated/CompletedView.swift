//
//  CompletedView.swift
//  Rakpom
//
//  Created by CatMeox on 14/6/2567 BE.
//

import SwiftUI

struct CompletedView: View {
  let barberID: String = "239958"
  
  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "checkmark.circle.fill")
        .resizable()
        .foregroundStyle(.black)
        .frame(width: 70, height: 70)
      
      Text("ลงทะเบียนสำเร็จ")
        .font(.custom("Noto Sans Thai", size: 18))
        .foregroundStyle(.black)
        .fontWeight(.bold)
        .padding(.bottom)
      
      Text("รหัสร้านค้าของคุณ")
        .font(.custom("Noto Sans Thai", size: 18))
        .foregroundColor(.black.opacity(0.8))
      
      Text(barberID)
        .font(.custom("Noto Sans Thai", size: 18))
        .fontWeight(.bold)
        .foregroundColor(.blueButton)
      
    }
    .frame(width: 308, height: 354)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 24))
  }
}

#Preview {
  CompletedView()
}
