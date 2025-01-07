//
//  AboutUsView.swift
//  Rakpom
//
//  Created by CatMeox on 10/6/2567 BE.
//

import SwiftUI

struct AboutUsView: View {
  var body: some View {
    VStack {
      Image(.logo2)
        .resizable()
        .scaledToFit()
        .frame(width: 178, height: 178)
      
      Text("เวอร์ชั่น \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "") (\(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""))")
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundColor(.gray)
    }
    .padding(.top, -64)
    .background(.white)
    .frame(maxHeight: .infinity)
    .ignoresSafeArea()
  }
}

#Preview {
  BackScaffold(title: "เกี่ยวกับเรา") {
    AboutUsView()
  }
}
