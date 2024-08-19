//
//  BackHeaderView.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI

struct BackHeaderView: View {
  let title: String
  let id: String
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
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
        
        Text(title)
          .font(.custom("Noto Sans Thai", size: 20))
          .foregroundStyle(.black)
          .padding()
      }
      
      Spacer()
      
      HStack(alignment: .center, spacing: 0) {
        NavigationLink(value: AnyHashable(HomeScreen(id: id))) {
          Image(systemName: "house")
            .resizable()
            .frame(width: 25, height: 22)
            .foregroundColor(Color("Black"))
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.7))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .padding(.top, -8)
        
        Image("Logo")
      }
    }
    .padding()
    .padding(.top, 40)
    .frame(maxWidth: .infinity)
    .frame(height: 133)
    .background(.blueApp)
  }
}

#Preview {
  BackHeaderView(title: "จองคิว", id: "qwerty")
}
