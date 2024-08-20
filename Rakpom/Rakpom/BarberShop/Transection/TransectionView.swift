//
//  TransectionView.swift
//  Rakpom
//
//  Created by CatMeox on 19/6/2567 BE.
//

import SwiftUI

struct TransectionView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BarberHeaderView()
        
        TitleView(title: "ร้านของฉัน", color: .white)
        ScrollView {
          VStack(spacing: 0) {
            Button {
              
            } label: {
              HStack(spacing: 16) {
                Image(systemName: "arrow.left.arrow.right")
                  .fontWeight(.bold)
                  .padding()
                  .foregroundColor(.white)
                  .frame(width: 66, height: 66)
                  .background(.blueButton)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                  Text("รับโอน")
                    .font(.custom("Noto Sans Thai", size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                  
                  Text("โอนจาก " + "กวิน ยินดี")
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundStyle(.black)
                  
                  Text("12/09/2023")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundStyle(.halfGray)
                }
                
                Spacer()
                
                VStack {
                  Text("฿ " + "150")
                    .font(.custom("Noto Sans Thai", size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 12)
                  
                  Spacer()
                }
              }
              .padding(25)
              .frame(height: 119)
              .background(.white)
              .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
              .padding(.top, 5)
            }
            
            Button {
              
            } label: {
              HStack(spacing: 16) {
                Image(systemName: "arrow.left.arrow.right")
                  .fontWeight(.bold)
                  .padding()
                  .foregroundColor(.white)
                  .frame(width: 66, height: 66)
                  .background(.blueButton)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                  Text("รับโอน")
                    .font(.custom("Noto Sans Thai", size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                  
                  Text("โอนจาก " + "กวิน ยินดี")
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundColor(.black)
                  
                  Text("12/09/2023")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundColor(.halfGray)
                }
                
                Spacer()
                
                VStack {
                  Text("฿ " + "150")
                    .font(.custom("Noto Sans Thai", size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 12)
                  
                  Spacer()
                }
              }
              .padding(25)
              .frame(height: 119)
              .background(.white)
              .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
              .padding(.top, 5)
            }
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
  }
}

#Preview {
  TransectionView()
}
