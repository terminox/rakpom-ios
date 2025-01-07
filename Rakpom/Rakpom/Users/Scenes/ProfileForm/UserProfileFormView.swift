//
//  UserProfileFormView.swift
//  Rakpom
//
//  Created by CatMeox on 12/6/2567 BE.
//

import PhotosUI
import SwiftUI

// MARK: - UserProfileFormView

struct UserProfileFormView: View {

  @ObservedObject var viewModel: UserProfileFormViewModel

  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  @State private var avatarImageData: Data?

  @State private var name = ""
  @State private var age = ""
  @State private var telNo = ""
  @State private var email = ""

  @State var gender: Gender?

  /// Description
  var body: some View {
    UserProfileFormContentView(
      avatarItem: $avatarItem,
      avatarImage: $avatarImage,
      avatarImageData: $avatarImageData,
      name: $name,
      age: $age,
      telNo: $telNo,
      email: $email,
      gender: $gender,
      onConfirmed: {
        Task { @MainActor in
          guard let imageData = avatarImageData, let gender else { return }
          let payload = UserSignupPayload(imageData: imageData, fullName: name, gender: gender, age: age, phone: telNo, email: email)
          await viewModel.submit(payload: payload)
        }
      })
  }
}

// MARK: - UserProfileFormContentView

struct UserProfileFormContentView: View {

  @Binding var avatarItem: PhotosPickerItem?
  @Binding var avatarImage: Image?
  @Binding var avatarImageData: Data?

  @Binding var name: String
  @Binding var age: String
  @Binding var telNo: String
  @Binding var email: String

  @Binding var gender: Gender?

  let onConfirmed: () -> Void
  
  var body: some View {
    ScrollView {
      VStack {
        ZStack {
          if avatarImage != nil {
            avatarImage?
              .resizable()
              .frame(width: 82, height: 82)
              .clipShape(Circle())
              .overlay(
                Circle()
                  .stroke(.blueButton, lineWidth: 3))
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
            }
            
            if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
              avatarImageData = data
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
                gender = .male
              } label: {
                if gender == .male {
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
                      .stroke(.blueButton))
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
                      .stroke(.halfGray))
                }
              }

              Button {
                gender = .female
              } label: {
                if gender == .female {
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
                      .stroke(.blueButton))
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
                      .stroke(.halfGray))
                }
              }
            }
          }

          TextFieldView(title: "อายุ", info: $age)

          TextFieldView(title: "เบอร์โทรศัพท์", info: $telNo)

          TextFieldView(title: "อีเมล (ถ้ามี)", info: $email)

          Button {
            onConfirmed()
          } label: {
            AppButton(title: "ลงทะเบียน")
              .padding(.horizontal, 36)
              .padding(.top)
          }
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  @Previewable @State var avatarItem: PhotosPickerItem?
  @Previewable @State var avatarImage: Image?
  @Previewable @State var avatarImageData: Data?

  @Previewable @State var name: String = ""
  @Previewable @State var age: String = ""
  @Previewable @State var telNo: String = ""
  @Previewable @State var email: String = ""

  @Previewable @State var gender: Gender?
  
  BackScaffold(title: "ลงทะเบียน") {
    UserProfileFormContentView(
      avatarItem: $avatarItem,
      avatarImage: $avatarImage,
      avatarImageData: $avatarImageData,
      name: $name,
      age: $age,
      telNo: $telNo,
      email: $email,
      gender: $gender,
      onConfirmed: {})
  }
}

// MARK: - TextFieldView

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
            .stroke(.halfGray))
    }
  }
}
