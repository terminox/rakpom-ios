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
            onConfirmed(.qr)
          } label: {
            OptionButton(title: "ชำระด้วยการแสกน", isSelected: false, width: geo.size.width / 1.3)
          }

          Button {
            onConfirmed(.cash)
          } label: {
            OptionButton(title: "ชำระด้วยเงินสด", isSelected: false, width: geo.size.width / 1.3)
          }

          Button {
            onConfirmed(.point)
          } label: {
            OptionButton(title: "ชำระด้วยแต้มสะสม", isSelected: false, width: geo.size.width / 1.3)
          }
        }
      }
    }
    .background(.blueBG)
    .ignoresSafeArea()
  }
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
