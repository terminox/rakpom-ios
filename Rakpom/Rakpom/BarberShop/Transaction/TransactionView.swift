//
//  TransectionView.swift
//  Rakpom
//
//  Created by CatMeox on 19/6/2567 BE.
//

import SwiftUI

struct TransactionDetail: Hashable, Identifiable {
  var id: String
  let type: String
}

struct TransactionView: View {
  let transactionDetails: [TransactionDetail] = [
    TransactionDetail(id: "1dgthgf", type: "Scan"),
    TransactionDetail(id: "3fef544", type: "Scan"),
    TransactionDetail(id: "6tg33de", type: "Cash"),
    TransactionDetail(id: "5656gfd", type: "Scan"),
    TransactionDetail(id: "3ef565t", type: "Cash")]
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        BarberHeaderView()
        
        TitleView(title: "ร้านของฉัน", color: .white)
        ScrollView {
          VStack(spacing: 0) {
            ForEach(transactionDetails) { transactionDetail in
              NavigationLink(value: AnyHashable(transactionDetail)) {
                if transactionDetail.type == "Scan" {
                  TransitionItems(type: "รับโอน", text: "โอนจาก ", price: "150")
                } else {
                  TransitionItems(type: "รับเงินสด", text: "จาก ", price: "150")
                }
              }
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
  TransactionView()
}

struct TransitionItems: View {
  let type: String
  let text: String
  let price: String
  
  var body: some View {
    HStack(spacing: 16) {
      Image(systemName: "arrow.left.arrow.right")
        .fontWeight(.bold)
        .padding()
        .foregroundColor(.white)
        .frame(width: 66, height: 66)
        .background(.blueButton)
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      VStack(alignment: .leading) {
        Text(type)
          .font(.custom("Noto Sans Thai", size: 16))
          .fontWeight(.bold)
          .foregroundStyle(.black)
        
        Text("\(text)" + "กวิน ยินดี")
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)
        
        Text("12/09/2023")
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.halfGray)
      }
      
      Spacer()
      
      VStack {
        Text("฿ " + "\(price)")
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
