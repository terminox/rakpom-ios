//
//  SignUpView.swift
//  Rakpom
//
//  Created by CatMeox on 12/6/2567 BE.
//

import SwiftUI

struct SignUpView: View {
  var body: some View {
    GeometryReader { geeo in
      ZStack {
        Image("BG")
          .resizable()
        
        VStack(spacing: 16) {
          Image("Logo2")
          
          Button {
            // Register with rakpom
          } label: {
            HStack {
              Image("Logo")
                .resizable()
                .frame(width: 33, height: 33)
                .padding(.leading, 44)
              Text("ลงทะเบียนด้วย รักผม")
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundStyle(.black)
                .padding(.leading, -6)
              
              Spacer()
            }
            .frame(width: 318, height: 42)
            .background(.white)
            .clipShape(Capsule())
            .overlay(
              Capsule()
                .stroke(.halfGray)
            )
          }
          
          Button {
            // Register with google
          } label: {
            SignUpSelectionView(title: "ดำเนินการด้วย Google", icon: Image("Google"))
          }
          
          Button {
            // Register with fb
          } label: {
            SignUpSelectionView(title: "ดำเนินการด้วย Facebook", icon: Image("FB"))
          }
          
          Button {
            // Register with line
          } label: {
            SignUpSelectionView(title: "ดำเนินการด้วย Line", icon: Image("Line"))
          }
          
          Button {
            //Register with apple
          } label : {
            SignUpSelectionView(title: "ดำเนินการด้วย Apple", icon: Image("Apple"))
          }
        }
      }
    }
    .ignoresSafeArea()
  }
}

#Preview {
  SignUpView()
}

struct SignUpSelectionView: View {
  let title: String
  let icon: Image
  
  var body: some View {
    HStack {
      icon
        .resizable()
        .frame(width: 20, height: 20)
        .padding(.leading, 50)
      Text(title)
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundStyle(.black)
      
      Spacer()
    }
    .frame(width: 318, height: 42)
    .background(.white)
    .clipShape(Capsule())
    .overlay(
    Capsule()
      .stroke(.halfGray)
    )
  }
}
