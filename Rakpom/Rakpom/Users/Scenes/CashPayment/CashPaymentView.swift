//
//  CashPaymentView.swift
//  Rakpom
//
//  Created by CatMeox on 30/5/2567 BE.
//

import SwiftUI

// MARK: - CashPaymentView

struct CashPaymentView: View {
  
  @ObservedObject var viewModel: CashPaymentViewModel

  @State private var price = ""
  @State private var shopID = ""

  var body: some View {
    CashPaymentContentView(price: $price, shopID: $shopID) {
      Task { @MainActor in
        await viewModel.submit(amount: price, shopCode: shopID)
      }
    }
  }
}

// MARK: - CashPaymentContentView

struct CashPaymentContentView: View {

  @Binding var price: String
  @Binding var shopID: String
  
  let onConfirmed: () -> Void

  var body: some View {
    GeometryReader { _ in
      VStack(spacing: 0) {
        TitleView(title: "ชำระด้วยเงินสด", color: .lightGray)

        ZStack {
          Image("Bluelabel")
          Image("CashPayment")
        }
        .padding(27)

        VStack(alignment: .leading, spacing: 8) {
          Text("ค่าบริการจำนวนเงิน")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)


          TextField("", text: $price)
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.blueButton))
            .padding(.bottom, 8)

          Text("รหัสร้านค้า")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          TextField("", text: $shopID)
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.blueButton))
        }
        .padding(.horizontal, 32)

        Button {
          onConfirmed()
        } label: {
          AppButton(title: "ยืนยัน")
            .padding(32)
        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  @Previewable @State var price = ""
  @Previewable @State var shopID = ""

  BackScaffold(title: "การชำระ") {
    CashPaymentContentView(price: $price, shopID: $shopID) {}
  }
}
