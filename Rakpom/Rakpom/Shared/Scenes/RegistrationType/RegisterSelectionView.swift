//
//  RegisterSelectionView.swift
//  Rakpom
//
//  Created by CatMeox on 11/6/2567 BE.
//

import SwiftUI

struct RegisterSelectionView: View {
  
  let onSelected: (RegistrationType) -> Void

  // MARK: Internal

  var body: some View {
    GeometryReader { _ in
      VStack {
        HStack {
          Text("ลงทะเบียน")
            .font(.custom("Noto Sans Thai", size: 20))
            .foregroundStyle(.black)
            .padding()

          Spacer()

          Image("Logo")

        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 133)
        .background(.blueApp)

        Text("เลือกการลงทะเบียนของคุณ")
          .font(.custom("Noto Sans Thai", size: 20))
          .foregroundStyle(.black)
          .padding(.top, 130)

        HStack(spacing: 40) {
          Button {
            selectedType = .user
          } label: {
            if selectedType == .user {
              VStack {
                Image("Person.2")
                  .renderingMode(.template)
                  .foregroundStyle(.black)
                  .padding()
                  .frame(width: 100, height: 100)
                  .background(.blueApp)
                  .clipShape(Circle())

                Text("ลูกค้า")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)
              }
            } else {
              VStack {
                Image("Person.2")
                  .padding()
                  .frame(width: 100, height: 100)
                  .overlay(
                    Circle()
                      .stroke(.blueButton))

                Text("ลูกค้า")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)
              }
            }
          }

          Button {
            selectedType = .shop
          } label: {
            if selectedType == .shop {
              VStack {
                Image("Scissors")
                  .renderingMode(.template)
                  .foregroundStyle(.black)
                  .padding()
                  .frame(width: 100, height: 100)
                  .background(.blueApp)
                  .clipShape(Circle())

                Text("ร้านตัดผม")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)
              }
            } else {
              VStack {
                Image("Scissors")
                  .padding()
                  .frame(width: 100, height: 100)
                  .overlay(
                    Circle()
                      .stroke(.blueButton))

                Text("ร้านตัดผม")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)
              }
            }
          }
        }
        .padding()

        Button {
          guard let selectedType = selectedType else { return }
          onSelected(selectedType)
        } label: {
          AppButton(title: "ถัดไป")
            .padding(36)
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }

  // MARK: Private

  @State private var selectedType: RegistrationType?
  
}

#Preview {
  RegisterSelectionView(onSelected: { _ in })
}
