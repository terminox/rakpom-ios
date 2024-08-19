//
//  ScanConfirmView.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI
import PhotosUI

struct ScanConfirmView: View {
  
  @State private var scanItem: PhotosPickerItem?
  @State private var scanImage: Image?
  
  @State var price: String = ""
  @State var shopID: String = ""
  
  let type: String
  
  var body: some View {
    GeometryReader { geo in
        VStack(alignment: .leading, spacing: 0) {
          BackHeaderView(title: "การชำระ", id: "qwerty")
          
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
            
            Text("รหัสอ้างอิง :" + "12345678")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundColor(.gray)
            
            if scanItem != nil {
              scanImage?
                .resizable()
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
                .stroke(.gray)
              )
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
                .stroke(.gray)
              )
            
            Button {
              // Payment confirmation
            } label: {
              AppButton(title: "ยืนยัน")
                .padding(.top, 14)
            }
          }
          .padding(30)
        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
    .onChange(of: scanItem) {
      Task {
        if let loaded = try? await scanItem?.loadTransferable(type: Image.self) {
          scanImage = loaded
        } else {
          print("Failed")
        }
      }
    }
  }
}

#Preview {
  ScanConfirmView(type: "Scan")
}
