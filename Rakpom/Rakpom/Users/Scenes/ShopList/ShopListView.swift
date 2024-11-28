//
//  ContentView.swift
//  Rakpom
//
//  Created by CatMeox on 17/5/2567 BE.
//

import SwiftUI

// MARK: - ShopListView

struct ShopListView: View {

  @ObservedObject var viewModel: ShopListViewModel

  var body: some View {
    let recentBookings = viewModel.recentBookings
    let bookings = viewModel.shops

    GeometryReader { geo in
      // SEARCH
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          //          HStack {
          //            Image(systemName: "magnifyingglass")
          //              .foregroundStyle(.gray)
          //              .font(.headline)
          //
          //            Text("ค้นหา...")
          //              .font(.custom("Noto Sans Thai", size: 14))
          //              .foregroundStyle(.black)
          //
          //            Spacer()
          //          }
          //          .padding()
          //          .frame(width: geo.size.width - 40, height: 44)
          //          .background(Color("LightGray"))
          //          .clipShape(Capsule())
          //          .padding()

          // LAST VISITED SHOPS
          VStack(alignment: .leading) {
            Text("ร้านตัดผมล่าสุด")
              .font(.custom("Noto Sans Thai", size: 18))
              .fontWeight(.medium)
              .foregroundStyle(.black)

            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(recentBookings) { booking in
                  Button(action: {
                    viewModel.select(booking)
                  }) {
                    RecentBookingItemView(shop: booking)
                  }
                  .buttonStyle(.plain)
                }
              }
              .padding(.horizontal, 4)
              .padding(.bottom, 16)
            }
          }
          .padding(.horizontal)

          // RESERVATION
          VStack(alignment: .leading) {
            Text("จองคิวตัดผม")
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundStyle(.black)
              .fontWeight(.medium)
              .padding()
              .frame(width: geo.size.width, height: 39, alignment: .leading)
              .background(.blueApp)

            ForEach(bookings) { booking in
              Button(action: {
                viewModel.select(booking)
              }) {
                BookingItemView(booking: booking, width: geo.size.width)
              }
              .buttonStyle(.plain)
            }
          }
          .background(Color("LightGray"))
        }
        .padding(.vertical)
      }
    }
    .background(.white)
    .ignoresSafeArea()
    .task {
      await viewModel.fetch()
    }
  }
}

// MARK: - RecentBookingItemView

struct RecentBookingItemView: View {

  let shop: ShopItem

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      AsyncImage(url: shop.imageURL, content: { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 131, height: 90)
          .clipped()
      }, placeholder: {
        Rectangle()
          .foregroundStyle(.halfGray)
          .frame(width: 131, height: 90)
      })
      .frame(width: 131, height: 90)
      .clipped()

      Text(shop.name)
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.black)
        .padding(.horizontal, 6)

      HStack(alignment: .top, spacing: 0) {
        Image(.location)
          .padding(.leading, 4)

        Text(shop.address)
          .font(.custom("Noto Sans Thai", size: 11))
          .foregroundStyle(.gray)
          .lineLimit(3)
          .padding(.horizontal, 4)
      }

      Spacer()
    }
    .frame(width: 131, height: 181)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 4)
  }
}

// MARK: - BookingItemView

struct BookingItemView: View {

  let booking: ShopItem
  let width: Double

  var body: some View {
    HStack(spacing: 16) {
      AsyncImage(url: booking.imageURL, content: { image in
        image
          .resizable()
          .scaledToFill()
          .frame(width: width / 3, height: 82)
      }, placeholder: {
        Rectangle()
          .foregroundStyle(.halfGray)
          .frame(width: width / 3, height: 82)
      })
      .frame(width: width / 3, height: 82)
      .clipShape(RoundedRectangle(cornerRadius: 4))

      VStack(alignment: .leading, spacing: 8) {
        Text(booking.name)
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)

        HStack(alignment: .firstTextBaseline, spacing: 0) {
          Image("Location")

          Text(booking.address)
            .multilineTextAlignment(.leading)
            .font(.custom("Noto Sans Thai", size: 13))
            .foregroundStyle(.gray)
            .lineLimit(3)
            .padding(.horizontal, 4)
        }
      }
      .padding(.top, 5)
    }
    .padding(.horizontal, 26)
    .padding(.vertical, 8)
    .frame(width: width, alignment: .leading)
//    .frame(minHeight: 97)
    .background(.white)
  }
}
