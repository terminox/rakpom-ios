//
//  NotificationView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

struct NotificationView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        TitleView(title: "แจ้งเตือน", color: .white)
        
        ScrollView {
          VStack(spacing: 0) {
            HStack(spacing: 16) {
              Image("Uppercut")
                .resizable()
                .frame(width: 63, height: 63)
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 4))
              
              VStack(alignment: .leading, spacing: 6) {
                HStack {
                  Text("ตัดผมฟรี")
                    .font(.custom("Noto Sans Thai", size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                  
                  Spacer()
                  
                  Text("12/09/2556")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundStyle(.halfGray)
                }
                
                Text(
"""
ตอนนี้คุณมีแต้มสะสมครบ 10 แต้ม
สามารถแลกสิทธิ์ตัดผมฟรีได้ทุกร้านที่ใช้ Uppercut
""")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundStyle(.darkGray)
              }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 110)
            .background(.white)
            .padding(.top, 5)
            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
            
            HStack(spacing: 16) {
              Image("Uppercut")
                .resizable()
                .frame(width: 63, height: 63)
                .padding()
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 4))
              
              VStack(alignment: .leading, spacing: 6) {
                HStack {
                  Text("จองร้านตัดผม")
                    .font(.custom("Noto Sans Thai", size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
                  
                  Spacer()
                  
                  Text("12/09/2556")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundStyle(.halfGray)
                }
                
                Text(
"""
ร้านลุงหนุ่ม ยกเลิกการจองของคุณ
หากต้องการจองอีกครั้ง กรุณาติดต่อทางร้านเพื่อสอบถามเวลา
""")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundStyle(.darkGray)
              }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 110)
            .background(.white)
            .padding(.top, 5)
            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
  }
}

#Preview {
  NotificationView()
}
