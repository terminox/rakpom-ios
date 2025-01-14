//
//  ShopHomeView.swift
//  Rakpom
//
//  Created by CatMeox on 14/6/2567 BE.
//

import SwiftUI

// MARK: - ShopHomeView

struct ShopHomeView: View {
  var body: some View {
    BarberHomeContenView()
  }
}

// MARK: - BarberHomeContenView

struct BarberHomeContenView: View {

  // MARK: Internal

  let imageNames: [String] = ["Barber1", "Barber2", "Barber3", "Barber4"]

  var data: [String] = ["Barber1", "Barber2", "Barber3", "Barber4"]

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        ScrollView {
          VStack(alignment: .leading, spacing: 8) {
            Text("ข้อมูลร้านค้า")
              .font(.custom("Noto Sans Thai", size: 16))
              .fontWeight(.bold)
              .foregroundStyle(.black)

            HStack {
              Image(systemName: "phone.fill")
                .font(.callout)
                .foregroundStyle(.blueButton)

              Text("095-458769")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundColor(.darkGray)
            }

            Text("เปิดร้าน 10:00 - 20:00 น.")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundColor(.darkGray)

            HStack(alignment: .firstTextBaseline, spacing: 6) {
              Image("Location")
                .resizable()
                .frame(width: 13, height: 15)

              Text("35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.darkGray)
                .lineLimit(3)
                .padding(.horizontal, 4)
            }
          }
          .padding()
          .frame(width: geo.size.width, alignment: .leading)

          Divider()
            .frame(width: geo.size.width, height: 4)
            .overlay(.lightGray)

          VStack(alignment: .leading, spacing: 12) {
            Text("รูปภาพของฉัน")
              .font(.custom("Noto Sans Thai", size: 16))
              .fontWeight(.bold)
              .foregroundStyle(.black)

            LazyVGrid(columns: adaptiveColumn, spacing: 20) {
              ForEach(data, id: \.self) { item in
                Image(item)
                  .frame(width: geo.size.width / 2.3, height: 122, alignment: .center)
                  .background(.blue)
                  .cornerRadius(4)
                  .foregroundColor(.white)
                  .font(.title)
              }
            }
          }
          .padding()
          .frame(width: geo.size.width, alignment: .leading)
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }

  // MARK: Private

  private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]

}

#Preview {
  BarberHomeContenView()
}
