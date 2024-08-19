//
//  ProfileSettingsView.swift
//  Rakpom
//
//  Created by CatMeox on 4/6/2567 BE.
//

import SwiftUI
import PhotosUI

struct UserGender: Hashable {
  let gender: String
}

struct ProfileSettingsView: View {
  @Environment(\.dismiss) var dismiss
  
  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  @State var name: String = ""
  @State var userID: String = "239958"
  @State var gender: String = "ชาย"
  @State var telNo: String = ""
  
  //  let type: String
  
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
        
        VStack(alignment: .leading) {
          Text("ชื่อ - นามสกุล")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)
          
          HStack {
            TextField("", text: $name)
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
            
            Image(systemName: "pencil")
              .foregroundColor(.halfGray)
          }
          .padding(.horizontal, 8)
          .padding(.bottom, 4)
          
          Divider()
            .frame(height: 1.5)
            .overlay(.blueButton)
            .padding(.bottom, 16)
          
          Text("รหัสสมาชิก")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)
          
          Text(userID)
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)
            .padding(.top, 4)
            .padding(.horizontal, 8)
          
          Divider()
            .frame(height: 1.5)
            .overlay(.halfGray)
            .padding(.bottom, 16)
          
          Text("เพศ")
            .font(.custom("Noto Sans Thai", size: 14))
            .foregroundStyle(.black)

          NavigationLink(value: AnyHashable(UserGender(gender: gender))) {
            HStack(spacing: 0) {
              Text(gender)
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.black)
              
              Spacer()
              
              Image(systemName: "pencil")
                .foregroundStyle(.halfGray)
            }
          }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            
            Divider()
              .frame(height: 1.5)
              .overlay(.halfGray)
              .padding(.bottom, 16)
            
            Text("เบอร์โทรศัพท์")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
            
            HStack {
              TextField("", text: $telNo)
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundColor(.black)
              
              Image(systemName: "pencil")
                .foregroundColor(.halfGray)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 4)
            
            Divider()
              .frame(height: 1.5)
              .overlay(.halfGray)
              .padding(.bottom, 16)
          }
          .padding(.horizontal, 32)
          
          Button {
            
          }label: {
            AppButton(title: "บันทึก")
              .padding(.vertical)
              .padding(.horizontal, 32)
          }
        }
      }
      .background(.white)
      .ignoresSafeArea()
    }
  }
  
  #Preview {
    ProfileSettingsView()
  }
