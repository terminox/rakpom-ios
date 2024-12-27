//
//  BookingConfirmationView.swift
//  Rakpom
//
//  Created by CatMeox on 24/5/2567 BE.
//

import SwiftUI

// MARK: - BookingConfirmationView

struct BookingConfirmationView: View {

  let items: [BookingConfirmationDetailItem]
  let onConfirmed: () -> Void
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      
      Image(systemName: "checkmark.circle")
        .resizable()
        .frame(width: 85, height: 85)
        .foregroundColor(Color("BlueButton"))
      
      Text("จองคิวสำเร็จ")
        .font(.custom("Noto Sans Thai", size: 20))
        .fontWeight(.bold)
        .foregroundStyle(.black)
        .padding(.bottom)
      
      VStack(alignment: .leading, spacing: 16) {
        ForEach(items) { item in
          HStack {
            Text(item.title)
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)
              .frame(width: 80, alignment: .leading)
            
            Text(":")
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)
              .padding(.trailing, 8)
            
            Text(item.value)
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)
          }
        }
      }
      
      Button {
        onConfirmed()
      } label: {
        AppButton(title: "กลับสู่หน้าหลัก")
      }
      .padding(.horizontal, 36)
      
      Spacer()
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

// MARK: - BookingConfirmationDetailItem

struct BookingConfirmationDetailItem: Identifiable, Hashable {
  let title: String
  let value: String

  var id: String {
    title + value
  }
}

#Preview {
  let items = [
    BookingConfirmationDetailItem(title: "ชื่อร้าน", value: "ร้านลุงหนุ่ม"),
    BookingConfirmationDetailItem(title: "ชื่อลูกค้า", value: "กวิน ยินดี"), 
    BookingConfirmationDetailItem(title: "วันที่", value: "01/09/2023"),
    BookingConfirmationDetailItem(title: "เวลาที่จอง", value: "09:00 - 10:00 น.")
  ]

  BookingConfirmationView(items: items, onConfirmed: {})
}
