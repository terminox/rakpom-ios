//
//  PaymentMethodSelectionView.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI

// MARK: - PaymentMethodSelectionView

struct PaymentMethodSelectionView: View {

  // MARK: Internal
  
  let onConfirmed: (PaymentMethod) -> Void

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        TitleView(title: "ยืนยันการชำระเงิน", color: .white)

        Text("เลือกการชำระเงินของคุณ")
          .font(.custom("Noto Sans Thai", size: 18))
          .foregroundStyle(.black)
          .padding(28)

        VStack(spacing: 20) {
          Button {
            selectedMethod = .qr
          } label: {
            OptionButton(title: "ชำระด้วยการแสกน", isSelected: selectedMethod == .qr, width: geo.size.width / 1.3)
          }

          Button {
            selectedMethod = .cash
          } label: {
            OptionButton(title: "ชำระด้วยเงินสด", isSelected: selectedMethod == .cash, width: geo.size.width / 1.3)
          }

          Button {
            selectedMethod = .point
          } label: {
            OptionButton(title: "ชำระด้วยแต้มสะสม", isSelected: selectedMethod == .point, width: geo.size.width / 1.3)
          }
        }

        Button(action: {
          guard let selectedMethod = selectedMethod else { return }
          onConfirmed(selectedMethod)
        }) {
          AppButton(title: "ถัดไป")
            .padding(36)
        }
        .buttonStyle(.plain)
      }
    }
    .background(.blueBG)
    .ignoresSafeArea()
  }

  // MARK: Private

  @State private var selectedMethod: PaymentMethod?
  
}

// MARK: - PaymentMethod

enum PaymentMethod {
  case qr
  case cash
  case point
}

#Preview {
  PaymentMethodSelectionView(onConfirmed: { _ in })
}
