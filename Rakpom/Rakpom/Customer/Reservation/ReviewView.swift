//
//  ReviewView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

struct ReviewView: View {
  let id: String
  
  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .leading, spacing: 0) {
        
        // HEADER
        BackHeaderView(title: "คะแนน", id: "qwerty")
        
        // Review
        ScrollView {
          VStack(alignment: .leading, spacing: 8) {
            HStack {
              HStack {
                Image("Reviewer")
                  .resizable()
                  .frame(width: 30, height: 30)
                  .clipShape(Circle())
                
                Text("เจนนี่ เจนนี่")
                  .font(.custom("Noto Sans Thai", size: 18))
                  .fontWeight(.medium)
                  .foregroundStyle(.black)
              }
              
              Spacer()
              
              Text("12/05/2023")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundStyle(.gray)
            }
            
            HStack(spacing: 4) {
              ForEach(0..<4) { _ in
                Image(systemName: "star.fill")
                  .font(.callout)
                  .foregroundColor(.yellow)
              }
              
              Image(systemName: "star.fill")
                .font(.callout)
                .foregroundColor(.gray)
            }
            .padding(.leading, 40)
            
            Text("บริการดีมาก ได้ทรงผมถูกใจ ราคาไม่แพง")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
              .padding(.top, 8)
          }
          .padding()
          
          Divider()
          
          VStack(alignment: .leading, spacing: 8) {
            HStack {
              HStack {
                Image("Reviewer")
                  .resizable()
                  .frame(width: 30, height: 30)
                  .clipShape(Circle())
                
                Text("เจนนี่ เจนนี่")
                  .font(.custom("Noto Sans Thai", size: 18))
                  .fontWeight(.medium)
                  .foregroundStyle(.black)
              }
              
              Spacer()
              
              Text("12/05/2023")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundStyle(.gray)
            }
            
            HStack(spacing: 4) {
              ForEach(0..<4) { _ in
                Image(systemName: "star.fill")
                  .font(.callout)
                  .foregroundColor(.yellow)
              }
              
              Image(systemName: "star.fill")
                .font(.callout)
                .foregroundColor(.gray)
            }
            .padding(.leading, 40)
            
            Text("บริการดีมาก ได้ทรงผมถูกใจ ราคาไม่แพง")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
              .padding(.top, 8)
          }
          .padding()
          
          Divider()
        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  ReviewView(id: "asd")
}
