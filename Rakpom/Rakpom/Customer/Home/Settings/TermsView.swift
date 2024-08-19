//
//  TemsView.swift
//  Rakpom
//
//  Created by CatMeox on 11/6/2567 BE.
//

import SwiftUI

struct TermsView: View {
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
            
            Text("เงื่อนไขการให้บริการ")
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
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  TermsView()
}
