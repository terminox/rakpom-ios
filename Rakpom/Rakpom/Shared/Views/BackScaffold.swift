//
//  BackScaffold.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import SwiftUI

// MARK: - BackScaffold

struct BackScaffold<Content: View>: View {

  let title: String?
  @ViewBuilder var content: Content

  var body: some View {
    VStack(spacing: .zero) {
      BackBar(title: title, back: { dismiss() })

      content
    }
  }

  @Environment(\.dismiss) private var dismiss

}

// MARK: - BackBar

struct BackBar: View {

  let title: String?
  let back: () -> Void

  var body: some View {
    HStack {
      HStack {
        Button {
          back()
        } label: {
          Image(systemName: "arrow.left")
            .resizable()
            .frame(width: 24, height: 20)
            .foregroundColor(.black)
        }

        if let title = title {
          Text("ลงทะเบียน")
            .font(.custom("Noto Sans Thai", size: 20))
            .foregroundStyle(.black)
            .padding()
        }
      }

      Spacer()

      Image("Logo")
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(.blueApp)
  }
}

#Preview {
  BackScaffold(title: nil) {
    EmptyView()
    Spacer()
  }
}
