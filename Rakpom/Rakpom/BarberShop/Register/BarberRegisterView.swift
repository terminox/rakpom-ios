//
//  BarberRegisterView.swift
//  Rakpom
//
//  Created by CatMeox on 13/6/2567 BE.
//

import SwiftUI
import PhotosUI

struct BarberRegisterView: View {
  @State private var barberItem: PhotosPickerItem?
  @State private var barberImage: Image?
  
  @State private var hairItem: PhotosPickerItem?
  @State private var hairImage: Image?
  
  @State private var name: String = ""
  @State private var ownerName: String = ""
  @State private var address: String = ""
  @State private var telNo: String = ""
  @State private var accountNo: String = ""
  @State private var openDate: String = ""
  @State private var closeDate: String = ""
  @State private var availableTime: String = ""
  @State private var price: String = ""
  
  @State var isMaleSelected: Bool = false
  @State var isFemaleSelected: Bool = false
  
  @State private var selectedBank = "กรุงศรีอยุธยา"
  let banks = ["กรุงศรีอยุธยา", "กรุงเทพ", "กรุงไทย", "กสิกรไทย", "เกียรตินาคินภัทร", "ซิตี้แบงค์", "ซีไอเอ็มบี", "ซูมิโตโม", "ดอยซ์แบงค์", "ทหารไทยธนชาต", "ทิสโก้", "ไทยเครดิต", "ไทยพาณิชย์", "บีเอ็นพี", "ธ.ก.ส.", "มิซูโฮ", "ยูโอบี", "แลนด์แอนด์เฮ้าส์", "สแตนดาร์ดชาร์เตอร์ด", "ออมสิน", "อาคารสงเคราะห์", "อิสลาม", "ไอซีบีซี", "เอชเอสบีซี"]
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        HStack {
          HStack {
            Button {
              // Back
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }
            
            Text("ลงทะเบียน")
              .font(.custom("Noto Sans Thai", size: 20))
              .foregroundStyle(.black)
              .padding()
          }
          
          Spacer()
          
          Image("Logo")
          
        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 133)
        .background(.blueApp)
        
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
            
            VStack(alignment: .leading, spacing: 4) {
            Text("ธนาคาร")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
            
              Picker("Bank", selection: $selectedBank) {
                ForEach(banks, id: \.self) {
                  Text($0)
                    .font(.custom("Noto Sans Thai", size: 14))
                    .padding()
                }
              }
              .frame(width: 320, height: 48)
              .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(.halfGray)
            )
            }

            TextFieldView(title: "เลขบัญชี", info: $accountNo)
            
            TextFieldView(title: "วันเปิดร้าน", info: $openDate)
            
            TextFieldView(title: "วันปิดร้าน", info: $closeDate)
            
            TextFieldView(title: "เวลาทำการ", info: $availableTime)
            
            TextFieldView(title: "ราคาตัดผม", info: $price)
            
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
                  if ((barberImage) != nil) {
                    barberImage?
                      .resizable()
                      .frame(width: 106, height: 87)
                      .clipShape(RoundedRectangle(cornerRadius: 4))
                  }
                }
              }
            } 
            
            VStack(alignment: .leading, spacing: 4) {
              Text("รูปภาพทรงผม")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.black)
              
              VStack(alignment: .leading) {
                PhotosPicker(selection: $hairItem, matching: .images) {
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
                  if ((hairImage) != nil) {
                    hairImage?
                      .resizable()
                      .frame(width: 106, height: 87)
                      .clipShape(RoundedRectangle(cornerRadius: 4))
                  }
                }
              }
            }
            
            Button {
              // register
            }label: {
              AppButton(title: "ยืนยัน")
                .padding(.top)
            }
          }
          .padding(.horizontal, 36)
        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
    .onChange(of: barberItem) {
      Task {
        if let loaded = try? await barberItem?.loadTransferable(type: Image.self) {
          barberImage = loaded
        } else {
          print("Failed")
        }
      }
    }
    .onChange(of: hairItem) {
      Task {
        if let loaded = try? await hairItem?.loadTransferable(type: Image.self) {
          hairImage = loaded
        } else {
          print("Failed")
        }
      }
    }
  }
}

#Preview {
  BarberRegisterView()
}
