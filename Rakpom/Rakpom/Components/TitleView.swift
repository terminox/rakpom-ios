//
//  TitleView.swift
//  Rakpom
//
//  Created by CatMeox on 19/6/2567 BE.
//

import SwiftUI

struct TitleView: View {
  let title: String
  let color: Color
  
  var body: some View {
    Text(title)
      .font(.custom("Noto Sans Thai", size: 18))
      .foregroundStyle(.black)
      .padding()
      .frame(maxWidth: .infinity)
      .background(color)
  }
}

#Preview {
  TitleView(title: "Hello", color: .red)
}
