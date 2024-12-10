//
//  QRPaymentView.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import PhotosUI
import SwiftUI

// MARK: - QRPaymentView

struct QRPaymentView: View {

  // MARK: Internal

  @ObservedObject var viewModel: QRPaymentViewModel

  var body: some View {
    QRPaymentStatelessView(
      scanItem: $scanItem,
      scanImage: $scanImage,
      imageData: $imageData,
      price: $price,
      shopID: $shopID,
      onSubmit: submit)
  }

  func submit() {
    Task { @MainActor in
      guard let imageData = imageData, !price.isEmpty, !shopID.isEmpty else { return }
      let payload = QRPaymentPayload(amount: price, shopCode: shopID, payslipImageData: imageData)
      await viewModel.submit(payload)
    }
  }

  // MARK: Private

  @State private var scanItem: PhotosPickerItem?
  @State private var scanImage: Image?
  @State private var imageData: Data?

  @State private var price = ""
  @State private var shopID = ""

}

// MARK: - QRPaymentStatelessView

struct QRPaymentStatelessView: View {

  @Binding var scanItem: PhotosPickerItem?
  @Binding var scanImage: Image?
  @Binding var imageData: Data?

  @Binding var price: String
  @Binding var shopID: String

  let onSubmit: () -> Void

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      TitleView(title: "ชำระด้วยการแสกน", color: .lightGray)

      ScrollView {
        VStack(alignment: .leading, spacing: 8) {
          Text("กรอกข้อมูลยืนยันการชำระเงิน")
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding(.bottom, 17)

          Text("อัพโหลดสลิป")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          if scanItem != nil {
            scanImage?
              .resizable()
              .scaledToFill()
              .frame(width: 327, height: 272)
              .clipShape(RoundedRectangle(cornerRadius: 12))
          } else {
            PhotosPicker(selection: $scanItem, matching: .images) {
              Label("อัพโหลดสลิป", image: "Upload")
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundColor(.gray)
                .frame(width: 181, height: 48)
                .background(.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 8)
            }
          }

          Text("จำนวนเงิน")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          TextField("", text: $price)
            .font(.custom("Noto Sans Thai", size: 16))
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.gray))
            .padding(.bottom, 8)

          Text("รหัสร้านค้าที่ให้บริการ")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          TextField("", text: $shopID)
            .font(.custom("Noto Sans Thai", size: 16))
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.gray))

          Button {
            onSubmit()
          } label: {
            AppButton(title: "ยืนยัน")
              .padding(.top, 14)
          }
        }
        .padding(30)
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
    .onChange(of: scanItem) {
      Task {
        if let loadedImage = try? await scanItem?.loadTransferable(type: Image.self) {
          scanImage = loadedImage
        }

        if let data = try? await scanItem?.loadTransferable(type: Data.self) {
          imageData = data
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var scanItem: PhotosPickerItem?
  @Previewable @State var scanImage: Image?
  @Previewable @State var imageData: Data?

  @Previewable @State var price = ""
  @Previewable @State var shopID = ""

  BackScaffold {
    QRPaymentStatelessView(
      scanItem: $scanItem,
      scanImage: $scanImage,
      imageData: $imageData,
      price: $price,
      shopID: $shopID,
      onSubmit: {})
  }
}
