//
//  ShopSettingsView.swift
//  Rakpom
//
//  Created by CatMeox on 5/7/2567 BE.
//

import SwiftUI
import PhotosUI

struct ShopSettingsView: View {
  @Environment(\.dismiss) var dismiss
  
  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  
  @State private var barberItem: PhotosPickerItem?
  @State private var barberImage: Image?
  
  @State private var hairItem: PhotosPickerItem?
  @State private var hairImage: Image?
  
  @State private var accName: String = ""
  @State private var accNumber: String = ""
  @State private var gender: String = ""
  @State private var phoneNumber: String = ""
  
  @State private var shopName: String = ""
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
              dismiss()
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }
            
            Text("แก้ไขข้อมูล")
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
              Spacer()
              
              ZStack {
                if ((avatarImage) != nil) {
                  avatarImage?
                    .resizable()
                    .frame(width: 82, height: 82)
                    .clipShape(Circle())
                    .overlay(
                      Circle()
                        .stroke(.blueButton, lineWidth: 3)
                    )
                } else {
                  Image(systemName: "person")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .frame(width: 82, height: 82)
                    .background(.lightGray)
                    .clipShape(Circle())
                }
                
                PhotosPicker(selection: $avatarItem, matching: .images) {
                  Image(systemName: "pencil")
                    .padding(6)
                    .foregroundColor(.white)
                    .background(.blueButton)
                    .clipShape(Circle())
                    .position(x: 50, y: 90)
                }
              }
              .frame(width: 100, height: 100)
              .onChange(of: avatarItem) {
                Task {
                  if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                  } else {
                    print("Failed")
                  }
                }
              }
              Spacer()
            }
            
            VStack(alignment: .leading, spacing: 16) {
              TextFieldView(title: "ชื่อบัญชีผู้ใช้", info: $accName)
              TextFieldView(title: "รหัสสมาชิก", info: $accNumber)
              TextFieldView(title: "เพศ", info: $accName)
              TextFieldView(title: "เบอร์โทรศัพท์", info: $accNumber)
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 36)
            
            HStack {
              Image("Scissors")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.black)
                .frame(width: 18, height: 18)
                .padding()
                .frame(width: 37, height: 37)
              
              Text("ข้อมูลร้านตัดผม")
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundColor(.black)
              
              Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(.blueApp)
            .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 16) {
              TextFieldView(title: "ชื่อร้าน", info: $shopName)
              
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
                AppButton(title: "บันทึก")
                  .padding(.top)
              }
            }
            .padding(.horizontal, 36)
          }
        }
      }
    }

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
  ShopSettingsView()
}
