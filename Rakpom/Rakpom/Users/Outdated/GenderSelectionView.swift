//
//  GenderSelectionView.swift
//  Rakpom
//
//  Created by CatMeox on 10/6/2567 BE.
//

import SwiftUI

struct GenderSelectionView: View {
  @State var isMaleSelected: Bool = false
  @State var isFemaleSelected: Bool = false
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        BackHeaderView(title: "เพศ", id: "qwerty")
        
        VStack(spacing: 20) {
          Button {
            isMaleSelected = true
            isFemaleSelected = false
          } label: {
            if isMaleSelected {
              HStack {
                Image("Male")
                  .renderingMode(.template)
                  .foregroundColor(.blueButton)
                Text("ชาย")
                
                Spacer()
              }
              .padding()
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundColor(.blueButton)
              .background(.white)
              .frame(width: geo.size.width * 0.8, height: 48)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(.blueButton, lineWidth: 1.5)
              )
            } else {
              HStack {
                Image("Male")
                  .renderingMode(.template)
                  .foregroundColor(.gray)
                Text("ชาย")
                
                Spacer()
              }
              .padding()
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundColor(.gray)
              .frame(width: geo.size.width * 0.8, height: 48)
              .background(.white)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(.halfGray, lineWidth: 1.5)
              )
            }
          }
          
          Button {
            isMaleSelected = false
            isFemaleSelected = true
          } label: {
            if isFemaleSelected {
              HStack {
                Image("Female")
                  .renderingMode(.template)
                  .foregroundColor(.blueButton)
                Text("หญิง")
                
                Spacer()
              }
              .padding()
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundColor(.blueButton)
              .background(.white)
              .frame(width: geo.size.width * 0.8, height: 48)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(.blueButton, lineWidth: 1.5)
              )
            } else {
              HStack {
                Image("Female")
                  .renderingMode(.template)
                  .foregroundColor(.gray)
                Text("หญิง")
                
                Spacer()
              }
              .padding()
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundColor(.gray)
              .frame(width: geo.size.width * 0.8, height: 48)
              .background(.white)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(.halfGray, lineWidth: 1.5)
              )
            }
          }
        }
        .padding(.vertical, 40)
        
        Button {
          // save
        } label: {
          AppButton(title: "บันทึก")
            .padding(.horizontal, 36)
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  GenderSelectionView()
}
