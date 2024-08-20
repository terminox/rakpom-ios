//
//  ConfirmReservation.swift
//  Rakpom
//
//  Created by CatMeox on 24/5/2567 BE.
//

import SwiftUI

struct DetailConfirmation: View {
  
  let confirm: ConfirmationLayoutItem
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      ForEach(confirm.rowItems, id: \.self) { item in
        HStack {
          Text(item.title)
            .frame(width: 80, alignment: .leading)
          Text(":")
            .padding(.trailing, 8)
          Text(item.value)
        }
      }
    }
    .foregroundStyle(.black)
  }
}

struct ConfirmReservationView: View {
  
  let confirm: ConfirmationLayoutItem
  @Binding var stackPath: [AnyHashable]
  
  var body: some View {
    GeometryReader { geo in
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
        
        DetailConfirmation(confirm: confirm)
          .font(.custom("Noto Sans Thai", size: 18))
        
        Button {
          // Back to Main Screen
          stackPath = []
        } label: {
          AppButton(title: "กลับสู่หน้าหลัก")
        }
        .padding(.horizontal, 36)
        
        Spacer()
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

struct ConfirmationLayoutItem: Hashable {
  let rowItems: [ConfirmationRowItem]
}

struct ConfirmationRowItem: Hashable {
  let title: String
  let value: String
}

//#Preview {
//  ConfirmReservationView(confirm: )
//}
