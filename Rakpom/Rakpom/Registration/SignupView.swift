//
//  SignUpView.swift
//  Rakpom
//
//  Created by CatMeox on 12/6/2567 BE.
//

import SwiftUI

// MARK: - SignupView

struct SignupView: View {

  let onSignupPressed: () -> Void

  var body: some View {
    ZStack {
      Image("BG")
        .resizable()

      VStack(spacing: 16) {
        Image("Logo2")

        Button {
          onSignupPressed()
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
              .stroke(.halfGray))
        }
      }
    }
    .ignoresSafeArea()
  }
}

#Preview {
  SignupView(onSignupPressed: {})
}

// MARK: - SignUpSelectionView

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
        .stroke(.halfGray))
  }
}
