//
//  ImportantNewsView.swift
//  Rakpom
//
//  Created by CatMeox on 3/7/2567 BE.
//

import SwiftUI

struct ImportantNewsView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          HStack {
            Button {
              // Back
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }
            
            Text("ข้อมูลของฉัน")
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
        
        HStack(spacing: 16) {
          Image("Barber2")
            .resizable()
            .frame(width: 65, height: 65)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(
              Circle()
                .stroke(Color.blueApp, lineWidth: 2.5))
          
          VStack(alignment: .leading) {
            Text("สวัสดี! ร้าน" + "ลุงหนุ่ม")
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)
            
            Text("รหัสร้านค้า : " + "436577")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundColor(.gray)
          }
          
          Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.vertical)
        
        HStack {
          Text("ข่าวสารสำคัญ")
            .font(.custom("Noto Sans Thai", size: 18))
            .foregroundStyle(.black)
          
          Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(.blueApp)
        
        ScrollView {
          VStack(spacing: 0) {
            HStack(spacing: 16) {
              Image("Logo")
                .resizable()
                .frame(width: 63, height: 63)
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 4))
              
              VStack(alignment: .leading, spacing: 6) {
                HStack {
                  Text("รักผมจ่ายให้")
                    .font(.custom("Noto Sans Thai", size: 14))
                    .foregroundStyle(.black)
                  
                  Spacer()
                  
                  Text("12/09/2556")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundStyle(.gray).opacity(0.7)
                }
                
                Text(
"""
คุณได้สิทธิ์เช่าร้านฟรี
""")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundStyle(.darkGray)
              }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 110)
            .background(.white)
            
            Divider()
              .frame(height: 4)
              .overlay(.lightGray)
          }
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  ImportantNewsView()
}
