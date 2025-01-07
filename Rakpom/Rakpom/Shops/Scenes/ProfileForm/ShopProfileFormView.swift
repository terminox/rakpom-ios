//
//  ShopProfileFormView.swift
//  Rakpom
//
//  Created by CatMeox on 13/6/2567 BE.
//

import PhotosUI
import SwiftUI

// MARK: - ShopProfileFormView

struct ShopProfileFormView: View {

  // MARK: Internal

  @ObservedObject var viewModel: ShopProfileFormViewModel

  var body: some View {
    ShopProfileFormContentView(
      barberItem: $barberItem,
      barberImage: $barberImage,
      barberImageData: $barberImageData,
      name: $name,
      ownerName: $ownerName,
      address: $address,
      telNo: $telNo,
      bankName: $bankName,
      accountNo: $accountNo,
      availableTime: $availableTime,
      price: $price,
      onConfirmed: {
        Task { @MainActor in
          guard let imageData = barberImageData else { return }
          let payload = ShopProfilePayload(
            name: name,
            ownerName: ownerName,
            address: address,
            phone: telNo,
            bankName: bankName,
            bankAccountNumber: accountNo,
            openingHours: availableTime,
            imageData: imageData)
          await viewModel.submit(payload: payload)
        }
      })
  }

  // MARK: Private

  @State private var barberItem: PhotosPickerItem?
  @State private var barberImage: Image?
  @State private var barberImageData: Data?
  @State private var name = ""
  @State private var ownerName = ""
  @State private var address = ""
  @State private var telNo = ""
  @State private var bankName = ""
  @State private var accountNo = ""
  @State private var availableTime = ""
  @State private var price = ""

}

// MARK: - ShopProfileFormContentView

struct ShopProfileFormContentView: View {

  @Binding var barberItem: PhotosPickerItem?
  @Binding var barberImage: Image?
  @Binding var barberImageData: Data?
  @Binding var name: String
  @Binding var ownerName: String
  @Binding var address: String
  @Binding var telNo: String
  @Binding var bankName: String
  @Binding var accountNo: String
  @Binding var availableTime: String
  @Binding var price: String

  let onConfirmed: () -> Void

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        HStack {
          Image("Scissors")
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(.black)
            .frame(width: 18, height: 18)
            .padding()
            .frame(width: 37, height: 37)
            .background(.blueApp)
            .clipShape(Circle())

          Text("กรอกข้อมูลร้านตัดผม")
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundColor(.black)

          Spacer()
        }
        .padding(.vertical)

        TextFieldView(title: "ชื่อร้าน", info: $name)

        TextFieldView(title: "ชื่อเจ้าของร้าน", info: $ownerName)

        TextFieldView(title: "ที่อยู่ร้าน", info: $address)

        TextFieldView(title: "เบอร์โทรศัพท์", info: $telNo)

        TextFieldView(title: "ธนาคาร", info: $bankName)

        TextFieldView(title: "เลขบัญชี", info: $accountNo)

        TextFieldView(title: "เวลาทำการ", info: $availableTime)

        VStack(alignment: .leading, spacing: 4) {
          Text("รูปภาพร้าน")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          VStack(alignment: .leading) {
            PhotosPicker(selection: $barberItem, matching: .images) {
              HStack {
                Image("Upload")
                Text("อัพโหลดรูปภาพ")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.gray)
              }
              .padding(.horizontal)
              .padding(.vertical, 6)
              .background(.lightGray)
              .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            ScrollView(.horizontal) {
              if barberImage != nil {
                barberImage?
                  .resizable()
                  .frame(width: 106, height: 87)
                  .clipShape(RoundedRectangle(cornerRadius: 4))
              }
            }
          }
        }

        Button {
          onConfirmed()
        } label: {
          AppButton(title: "ยืนยัน")
            .padding(.top)
        }
      }
      .padding(.horizontal, 36)
    }
    .background(.white)
    .onChange(of: barberItem) {
      Task {
        if let loaded = try? await barberItem?.loadTransferable(type: Image.self) {
          barberImage = loaded
        }

        if let data = try? await barberItem?.loadTransferable(type: Data.self) {
          barberImageData = data
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var barberItem: PhotosPickerItem?
  @Previewable @State var barberImage: Image?
  @Previewable @State var barberImageData: Data?
  @Previewable @State var name = ""
  @Previewable @State var ownerName = ""
  @Previewable @State var address = ""
  @Previewable @State var telNo = ""
  @Previewable @State var bankName = ""
  @Previewable @State var accountNo = ""
  @Previewable @State var availableTime = ""
  @Previewable @State var price = ""

  BackScaffold(title: "ลงทะเบียน") {
    ShopProfileFormContentView(
      barberItem: $barberItem,
      barberImage: $barberImage,
      barberImageData: $barberImageData,
      name: $name,
      ownerName: $ownerName,
      address: $address,
      telNo: $telNo,
      bankName: $bankName,
      accountNo: $accountNo,
      availableTime: $availableTime,
      price: $price,
      onConfirmed: {})
  }
}
