//
//  WithdrawHistoryView.swift
//  Rakpom
//
//  Created by CatMeox on 25/6/2567 BE.
//

import SwiftUI

struct WithdrawHistoryView: View {
  
  @ObservedObject var viewModel: WithdrawHistoryViewModel
  
  var body: some View {
    WithdrawHistoryContentView(items: viewModel.items)
      .task {
        await viewModel.fetchItems()
      }
  }
}

// MARK: - WithdrawHistoryContentView

struct WithdrawHistoryContentView: View {

  let items: [WithdrawHistoryItem]

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(items) { item in
          VStack(spacing: 0) {
            WithdrawHistoryItemView(item: item)

            Divider()
          }
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

// MARK: - WithdrawHistoryItemView

struct WithdrawHistoryItemView: View {

  let item: WithdrawHistoryItem

  var body: some View {
    HStack(spacing: 20) {
      Image(systemName: "arrow.left.arrow.right")
        .resizable()
        .frame(width: 23, height: 25)
        .bold()
        .padding()
        .foregroundColor(.white)
        .frame(width: 66, height: 66)
        .background(.blueButton)
        .clipShape(RoundedRectangle(cornerRadius: 8))

      VStack(alignment: .leading) {
        Text("ถอนเงิน")

        Text(item.dateString)
          .foregroundStyle(.gray)
      }
      .font(.custom("Noto Sans Thai", size: 16))
      .foregroundStyle(.black)

      Spacer()

      Text(item.amountString)
        .font(.custom("Noto Sans Thai", size: 22))
        .fontWeight(.medium)
        .foregroundStyle(.black)
    }
    .padding(.horizontal, 25)
    .padding(.vertical, 16)
  }
}

#Preview {
  let items = [
    WithdrawHistoryItem(
      id: UUID().uuidString,
      title: "ถอนเงิน",
      dateString: "01/01/2024 13:45",
      amountString: "฿1,000.00"),
    WithdrawHistoryItem(
      id: UUID().uuidString,
      title: "ถอนเงิน",
      dateString: "31/12/2023 09:30",
      amountString: "฿500.00"),
    WithdrawHistoryItem(
      id: UUID().uuidString,
      title: "ถอนเงิน",
      dateString: "30/12/2023 15:20",
      amountString: "฿750.00"),
  ]

  BackScaffold(title: "ประวัติการถอนเงิน") {
    WithdrawHistoryContentView(items: items)
  }
}
