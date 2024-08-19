//
//  Button.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI

struct AppButton: View {
  let title: String
  
  var body: some View {
    Text(title)
      .font(.custom("Noto Sans Thai", size: 16))
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity)
      .frame(height: 47)
      .background(Color("BlueButton"))
      .clipShape(Capsule())
  }
}

#Preview {
  AppButton(title: "ยืนยัน")
}
