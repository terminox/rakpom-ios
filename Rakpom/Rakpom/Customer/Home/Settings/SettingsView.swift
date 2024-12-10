//
//  SettingsView.swift
//  Rakpom
//
//  Created by CatMeox on 2/6/2567 BE.
//

import SwiftUI

// MARK: - SettingsView

struct SettingsView: View {

  // MARK: Internal

  let onProfilePressed: () -> Void
  let onAboutUsPressed: () -> Void
  let onPrivacyPolicyPressed: () -> Void
  let onTermsPressed: () -> Void
  let onLogoutPressed: () -> Void

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
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

            Text("ตั้งค่า")
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

        // User Info
        HStack {
          Image("User")
            .resizable()
            .frame(width: 53, height: 53)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(
              Circle()
                .stroke(Color.blueApp, lineWidth: 2.5))

          VStack(alignment: .leading) {
            Text("สวัสดี! " + "คุณอภิเดช")
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)

            Text("รหัสสมาชิก :" + " " + "123456")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundColor(.gray)
          }

          Spacer()
        }
        .padding(24)
        .background(.blueBG)

        VStack(spacing: 0) {
          // Notifications
//          HStack {
//            Image(systemName: "bell")
//              .foregroundStyle(.black)
//            Toggle("การแจ้งเตือน", isOn: $notification)
//              .font(.custom("Noto Sans Thai", size: 16))
//              .foregroundStyle(.black)
//              .toggleStyle(SwitchToggleStyle(tint: .blueButton))
//          }
//          .padding(20)
//          .frame(width: geo.size.width, height: 72)
//          .background(.white)

          Divider()
            .frame(height: 4)
            .overlay(.blueBG)

          // Profile
          HStack {
            Button {
              onProfilePressed()
            } label: {
              HStack {
                Image(systemName: "person")
                  .foregroundColor(.black)

                Text("โปรไฟล์ของฉัน")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)

                Spacer()

                Image(systemName: "chevron.right")
                  .foregroundColor(.gray)
              }
              .padding(20)
            }
          }
          .frame(width: geo.size.width, height: 72)
          .background(.white)

          Divider()
            .frame(height: 4)
            .overlay(.blueBG)

          // About Us
          HStack {
            Button {
              onAboutUsPressed()
            } label: {
              HStack {
                Image(systemName: "info.circle")
                  .foregroundColor(.black)

                Text("เกี่ยวกับเรา")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)

                Spacer()

                Image(systemName: "chevron.right")
                  .foregroundColor(.gray)
              }
              .padding(20)
            }
          }
          .frame(width: geo.size.width, height: 72)
          .background(.white)

          Divider()
            .frame(height: 4)
            .overlay(.blueBG)

          HStack {
            Button {
              onPrivacyPolicyPressed()
            } label: {
              HStack {
                Image(systemName: "list.clipboard")
                  .foregroundStyle(.black)

                Text("นโยบายความเป็นส่วนตัว")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundStyle(.black)

                Spacer()

                Image(systemName: "chevron.right")
                  .foregroundStyle(.gray)
              }
              .padding(20)
            }
          }
          .frame(width: geo.size.width, height: 72)
          .background(.white)

          Divider()
            .frame(height: 4)
            .overlay(.blueBG)

          HStack {
            Button {
              onTermsPressed()
            } label: {
              HStack {
                Image(systemName: "doc")
                  .foregroundColor(.black)

                Text("เงื่อนไขการให้บริการ")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundColor(.black)

                Spacer()

                Image(systemName: "chevron.right")
                  .foregroundColor(.gray)
              }
              .padding(20)

            }
          }
          .frame(width: geo.size.width, height: 72)
          .background(.white)

          Divider()
            .frame(height: 4)
            .overlay(.blueBG)
        }

        // Logout
        Button {
          onLogoutPressed()
        } label: {
          Text("ออกจากระบบ")
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.blueButton)
            .frame(maxWidth: .infinity)
            .frame(height: 47)
            .background(.white)
            .clipShape(Capsule())
            .overlay(
              RoundedRectangle(cornerRadius: 50)
                .stroke(Color("BlueButton")))
        }
        .padding(.vertical, 46)
        .padding(.horizontal, 84)
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }

  // MARK: Private

  @Environment(\.dismiss) private var dismiss

  @State private var notification = true

}

#Preview {
  SettingsView(onProfilePressed: {}, onAboutUsPressed: {}, onPrivacyPolicyPressed: {}, onTermsPressed: {}, onLogoutPressed: {})
}
