//
//  PointPaymentView.swift
//  Rakpom
//
//  Created by CatMeox on 30/5/2567 BE.
//

import SwiftUI

// MARK: - PointPaymentView

struct PointPaymentView: View {

  @ObservedObject var viewModel: PointPaymentViewModel

  @State private var points = ""
  @State private var shopID = ""

  var body: some View {
    PointPaymentContentView(points: $points, shopID: $shopID) {
      Task { @MainActor in
        let payload = PointPaymentPayload(points: points, shopCode: shopID)
        await viewModel.submit(payload: payload)
      }
    }
  }
}

// MARK: - PointPaymentContentView

struct PointPaymentContentView: View {

  @Binding var points: String
  @Binding var shopID: String
  
  let onConfirmed: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      TitleView(title: "ชำระด้วยแต้มสะสม", color: .lightGray)

      Image("Treasure")

      VStack {
        Text("ต้องการแลกสิทธิ์การตัดผมฟรี\nโดยใช้แต้มสะสมใช่หรือไม่ม")
          .multilineTextAlignment(.center)
      }
      .font(.custom("Noto Sans Thai", size: 16))
      .foregroundStyle(.black)
      .padding(.bottom, 36)

      VStack(alignment: .leading, spacing: 8) {
        Text("แต้มที่ใช้")
          .font(.custom("Noto Sans Thai", size: 14))
          .foregroundStyle(.black)

        TextField("", text: $points)
          .keyboardType(.numberPad)
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)
          .padding()
          .frame(maxWidth: .infinity)
          .frame(height: 48)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .stroke(.blueButton))
      }
      .padding(.horizontal, 72)
      
      VStack(alignment: .leading, spacing: 8) {
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
      .padding(.horizontal, 72)
      .padding(.top, 16)

      Button {
        onConfirmed()
      } label: {
        AppButton(title: "ยืนยัน")
          .padding(32)
      }
      
      Spacer()
    }
//    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  @Previewable @State var points = ""
  @Previewable @State var shopID = ""

  BackScaffold {
    PointPaymentContentView(points: $points, shopID: $shopID, onConfirmed: {})
  }
}
