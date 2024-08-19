//
//  AboutUsView.swift
//  Rakpom
//
//  Created by CatMeox on 10/6/2567 BE.
//

import SwiftUI

struct AboutUsView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        HStack {
          HStack {
            Button {
              dismiss()
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }
            
            Text("เกี่ยวกับเรา")
              .font(.custom("Noto Sans Thai", size: 20))
              .foregroundStyle(.black)
              .padding()
          }
          
          Spacer()
          
          Image("Logo")
          
        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 133)
        .background(.blueApp)
        
        Image("Logo2")
          .resizable()
          .frame(width: 178, height: 178)
          .padding(.top, 200)
        
        Text("เวอร์ชั่น " + "1.0.1")
          .font(.custom("Noto Sans Thai", size: 16))
          .padding(.top, -30)
          .foregroundColor(.gray)
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  AboutUsView()
}
