//
//  ShopHomeView.swift
//  Rakpom
//
//  Created by CatMeox on 14/6/2567 BE.
//

import SwiftUI

// MARK: - ShopHomeView

struct ShopHomeView: View {

  @ObservedObject var viewModel: ShopHomeViewModel

  var body: some View {
    VStack {
      if viewModel.isLoading {
        Spacer()

        ProgressView()
          .progressViewStyle(.circular)

        Spacer()
      } else if let item = viewModel.item {
        ShopHomeContentView(item: item)
      }
    }
    .onAppear(perform: viewModel.onAppear)
  }
}

// MARK: - ShopHomeContentView

struct ShopHomeContentView: View {

  // MARK: Internal

  let item: ShopHomeDetailItem

//  let imageNames: [String] = ["Barber1", "Barber2", "Barber3", "Barber4"]

//  var data: [String] = ["Barber1", "Barber2", "Barber3", "Barber4"]

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        ScrollView {
          AsyncImage(
            url: item.coverImageURL,
            content: { image in
              image
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.width * 2 / 3, alignment: .center)
                .clipped()
                .background(.lightGray)
            },
            placeholder: {
              Rectangle()
                .frame(width: geo.size.width, height: geo.size.width * 2 / 3, alignment: .center)
                .foregroundStyle(.lightGray)
            })

          VStack(alignment: .leading, spacing: 8) {
            Text("ข้อมูลร้านค้า")
              .font(.custom("Noto Sans Thai", size: 16))
              .fontWeight(.bold)
              .foregroundStyle(.black)

            HStack {
              Image(systemName: "phone.fill")
                .font(.callout)
                .foregroundStyle(.blueButton)

              Text(item.telNo)
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundColor(.darkGray)
            }

//            Text(item.businessHours)
//              .font(.custom("Noto Sans Thai", size: 14))
//              .foregroundColor(.darkGray)

            HStack(alignment: .firstTextBaseline, spacing: 6) {
              Image(.location)
                .resizable()
                .frame(width: 13, height: 15)

              Text(item.address)
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.darkGray)
                .lineLimit(3)
                .padding(.horizontal, 4)
            }
          }
          .padding()
          .frame(width: geo.size.width, alignment: .leading)

//          Divider()
//            .frame(width: geo.size.width, height: 4)
//            .overlay(.lightGray)
//
//          VStack(alignment: .leading, spacing: 12) {
//            Text("รูปภาพของฉัน")
//              .font(.custom("Noto Sans Thai", size: 16))
//              .fontWeight(.bold)
//              .foregroundStyle(.black)
//
//            LazyVGrid(columns: adaptiveColumn, spacing: 20) {
//              ForEach(data, id: \.self) { item in
//                Image(item)
//                  .frame(width: geo.size.width / 2.3, height: 122, alignment: .center)
//                  .background(.blue)
//                  .cornerRadius(4)
//                  .foregroundColor(.white)
//                  .font(.title)
//              }
//            }
//          }
//          .padding()
//          .frame(width: geo.size.width, alignment: .leading)
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
  let item = ShopHomeDetailItem(
    coverImageURL: URL(string: "http://example.com")!,
    telNo: "095-458769",
//    businessHours: "เปิดร้าน 10:00 - 20:00 น.",
    address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")

  ShopHomeContentView(item: item)
}
