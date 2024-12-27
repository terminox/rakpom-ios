//
//  PhoneFormView.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import SwiftUI

struct PhoneFormView: View {
  
  let onSubmit: (String) -> Void

  // MARK: Internal

  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 16) {
        TextFieldView(title: "เบอร์โทรศัพท์", info: $telNo)

        Button {
          guard !telNo.isEmpty else { return }
          onSubmit(telNo)
        } label: {
          AppButton(title: "ต่อไป")
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

  @State private var telNo = ""
}

#Preview {
  BackScaffold(title: "ลงทะเบียน") {
    PhoneFormView(onSubmit: { _ in })
  }
}
