//
//  RakpomSignUpView.swift
//  Rakpom
//
//  Created by CatMeox on 12/6/2567 BE.
//

import SwiftUI
import PhotosUI

struct RakpomSignUpView: View {
  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  
  @State private var name: String = ""
  @State private var age: String = ""
  @State private var telNo: String = ""
  @State private var email: String = ""
  
  @State var isMaleSelected: Bool = false
  @State var isFemaleSelected: Bool = false
  
  /// <#Description#>
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
              Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .frame(width: 82, height: 82)
                .background(.lightGray)
                .foregroundColor(.halfGray)
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
          .padding()
          .onChange(of: avatarItem) {
            Task {
              if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                avatarImage = loaded
              } else {
                print("Failed")
              }
            }
          }
          
          VStack(spacing: 16) {
            TextFieldView(title: "ชื่อบัญชีผู้ใช้", info: $name)
            
            VStack(alignment: .leading, spacing: 4) {
              Text("เพศ")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.black)
              
              HStack(spacing: 16) {
                Button {
                  isMaleSelected = true
                  isFemaleSelected = false
                } label: {
                  if isMaleSelected {
                    HStack {
                      Image("Male")
                        .renderingMode(.template)
                        .foregroundColor(.blueButton)
                      Text("ชาย")
                      
                      Spacer()
                    }
                    .padding()
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundColor(.blueButton)
                    .background(.white)
                    .frame(width: 160 - 8, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                      RoundedRectangle(cornerRadius: 12)
                        .stroke(.blueButton)
                    )
                  } else {
                    HStack {
                      Image("Male")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                      Text("ชาย")
                      
                      Spacer()
                    }
                    .padding()
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundColor(.gray)
                    .frame(width: 160 - 8, height: 48)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                      RoundedRectangle(cornerRadius: 12)
                        .stroke(.halfGray)
                    )
                  }
                }
                
                Button {
                  isMaleSelected = false
                  isFemaleSelected = true
                } label: {
                  if isFemaleSelected {
                    HStack {
                      Image("Female")
                        .renderingMode(.template)
                        .foregroundColor(.blueButton)
                      Text("หญิง")
                      
                      Spacer()
                    }
                    .padding()
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundColor(.blueButton)
                    .background(.white)
                    .frame(width: 160 - 8, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                      RoundedRectangle(cornerRadius: 12)
                        .stroke(.blueButton)
                    )
                  } else {
                    HStack {
                      Image("Female")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                      Text("หญิง")
                      
                      Spacer()
                    }
                    .padding()
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundColor(.gray)
                    .frame(width: 160 - 8, height: 48)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                      RoundedRectangle(cornerRadius: 12)
                        .stroke(.halfGray)
                    )
                  }
                }
              }
            }
            
            TextFieldView(title: "อายุ", info: $age)
            
            TextFieldView(title: "เบอร์โทรศัพท์", info: $telNo)
            
            TextFieldView(title: "อีเมล (ถ้ามี)", info: $email)
            
            Button {
              // register
            }label: {
              AppButton(title: "ลงทะเบียน")
                .padding(.horizontal, 36)
                .padding(.top)
            }
          }
        }
      }
    }
    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  RakpomSignUpView()
}

struct TextFieldView: View {
  let title: String
  @Binding var info: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .font(.custom("Noto Sans Thai", size: 14))
        .foregroundStyle(.black)
      
      TextField("", text: $info)
        .font(.custom("Noto Sans Thai", size: 14))
        .foregroundStyle(.black)
        .padding()
        .frame(width: 320, height: 48)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .stroke(.halfGray)
        )
    }
  }
}
