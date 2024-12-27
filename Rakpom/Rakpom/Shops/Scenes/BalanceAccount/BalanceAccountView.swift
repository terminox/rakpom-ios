//
//  BalanceAccountView.swift
//  Rakpom
//
//  Created by CatMeox on 24/6/2567 BE.
//

import SwiftUI

// MARK: - BalanceAccountView

struct BalanceAccountView: View {

  @ObservedObject var viewModel: BalanceAccountViewModel
  let onWithdrawPressed: () -> Void
  let onWithdrawHistoryPressed: () -> Void

  var body: some View {
    BalanceAccountContentView(
      items: viewModel.items,
      onWithdrawPressed: onWithdrawPressed,
      onWithdrawHistoryPressed: onWithdrawHistoryPressed)
      .onAppear(perform: viewModel.onAppear)
  }
}

// MARK: - BalanceAccountContentView

struct BalanceAccountContentView: View {

  let items: [BalanceAccountItem]
  let onWithdrawPressed: () -> Void
  let onWithdrawHistoryPressed: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      TitleView(title: "บัญชีของคุณ", color: .lightGray)

      ScrollView {
        VStack(spacing: 0) {
          ForEach(items) { item in
            ListData(title: item.title, number: item.value, color: item.color)
          }
        }

        Button {
          onWithdrawPressed()
        } label: {
          AppButton(title: "ถอนเงิน")
        }
        .padding(.horizontal, 36)
        .padding(.top, 27)

        Button {
          onWithdrawHistoryPressed()
        } label: {
          Text("ดูประวัติการถอนเงิน")
            .foregroundColor(.blueButton)
            .font(.custom("Noto Sans Thai", size: 16))
            .underline()
            .padding()
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

// MARK: - ListData

struct ListData: View {
  let title: String
  let number: String
  let color: Color

  var body: some View {
    HStack {
      Text(title)
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundStyle(.black)

      Spacer()

      Text(number)
        .foregroundColor(color)
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundStyle(.black)
    }
    .padding()

    Divider()
  }
}

extension BalanceAccountItem {
  var color: Color {
    switch style {
    case .positive:
      return .green
    case .negative:
      return .red
    case .bold, .regular:
      return .black
    }
  }
}

#Preview {
  let items: [BalanceAccountItem] = [
    BalanceAccountItem(title: "ยอดในระบบ", value: "120.00", style: .bold),
    BalanceAccountItem(title: "ยอดชำระสแกนจ่าย", value: "+100.00", style: .positive),
    BalanceAccountItem(title: "ยอดชำระเงินสด", value: "-20.00", style: .negative),
    BalanceAccountItem(title: "ยอดคอมมิชชั่น", value: "10%", style: .bold),
    BalanceAccountItem(title: "ภาษีมูลค่าเพิ่ม", value: "7%", style: .bold),
    BalanceAccountItem(title: "ยอดที่ถอนได้", value: "0", style: .negative),
  ]

  BalanceAccountContentView(items: items, onWithdrawPressed: {}, onWithdrawHistoryPressed: {})
}
