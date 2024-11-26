//
//  OptionButton.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI

struct OptionButton: View {
  let title: String
  let isSelected: Bool
  let width: Double
  
  var body: some View {
    if isSelected {
      Text(title)
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundColor(.black)
        .frame(width: width, height: 48)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
        RoundedRectangle(cornerRadius: 12)
          .stroke(.blueButton, lineWidth: 1.5)
        )
    } else {
      Text(title)
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundColor(.black)
        .frame(width: width, height: 48)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
  }
}

#Preview {
  OptionButton(title: "ABCDEFG", isSelected: true, width: 300)
}
