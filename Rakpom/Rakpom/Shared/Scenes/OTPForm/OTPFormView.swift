//
//  OTPFormView.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import SwiftUI

struct OTPFormView: View {

  // MARK: Internal

  let onSubmit: (String) -> Void

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 16) {
        TextFieldView(title: "กรุณากรอก OTP ที่ส่งไปยังเบอร์โทรศัพท์ของคุณ", info: $otp)

        Button {
          guard !otp.isEmpty else { return }
          onSubmit(otp)
        } label: {
          AppButton(title: "ยืนยันและลงทะเบียน")
            .padding(.horizontal, 36)
            .padding(.top)
        }
      }
      .padding(.vertical, 24)
    }
    .background(.white)
    .ignoresSafeArea()
  }

  // MARK: Private

  @State private var otp = ""
  
}

#Preview {
  BackScaffold(title: "ลงทะเบียน") {
    OTPFormView(onSubmit: { _ in })
  }
}
