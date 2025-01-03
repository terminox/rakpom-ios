//
//  TransectionView.swift
//  Rakpom
//
//  Created by CatMeox on 19/6/2567 BE.
//

import SwiftUI

// MARK: - TransactionListView

struct TransactionListView: View {
  
  @ObservedObject var viewModel: TransactionListViewModel
  
  var body: some View {
    TransactionListContentView(items: viewModel.items)
      .onAppear(perform: viewModel.onAppear)
  }
}

// MARK: - TransactionListContentView

struct TransactionListContentView: View {
  let items: [TransactionItem]

  var body: some View {
    VStack(spacing: 0) {
      TitleView(title: "ร้านของฉัน", color: .white)

      ScrollView {
        VStack(spacing: 0) {
          ForEach(items) { item in
            TransactionItemView(item: item)
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
  }
}

// MARK: - TransactionItemView

struct TransactionItemView: View {

  let item: TransactionItem

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
        Text(item.title)
          .font(.custom("Noto Sans Thai", size: 16))
          .fontWeight(.bold)
          .foregroundStyle(.black)

        Text(item.description)
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)

        Text(item.dateString)
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.halfGray)
      }

      Spacer()

      VStack {
        Text(item.amountString)
          .font(.custom("Noto Sans Thai", size: 18))
          .fontWeight(.bold)
          .foregroundColor(item.amount > 0 ? .green : .red)
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

#Preview {
  let items = [
    TransactionItem(
      id: "1",
      title: "รับโอน",
      description: "โอนจาก กวิน ยินดี",
      dateString: "12/09/2556",
      amount: 150,
      amountString: "฿150"),
    TransactionItem(
      id: "2",
      title: "รับโอน",
      description: "โอนจาก กวิน ยินดี",
      dateString: "12/09/2556",
      amount: 150,
      amountString: "฿150"),
    TransactionItem(
      id: "3",
      title: "รับโอน",
      description: "โอนจาก กวิน ยินดี",
      dateString: "12/09/2556",
      amount: 150,
      amountString: "฿150"),
    TransactionItem(
      id: "4",
      title: "รับโอน",
      description: "โอนจาก กวิน ยินดี",
      dateString: "12/09/2556",
      amount: 150,
      amountString: "฿150"),
    TransactionItem(
      id: "5",
      title: "รับโอน",
      description: "โอนจาก กวิน ยินดี",
      dateString: "12/09/2556",
      amount: 150,
      amountString: "฿150"),
  ]

  TransactionListContentView(items: items)
}
