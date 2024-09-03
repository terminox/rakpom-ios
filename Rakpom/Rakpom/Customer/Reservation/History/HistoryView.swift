//
//  ContentView.swift
//  Rakpom
//
//  Created by CatMeox on 17/5/2567 BE.
//

import SwiftUI

struct RecentBookingItem: Identifiable, Hashable {
  static func == (lhs: RecentBookingItem, rhs: RecentBookingItem) -> Bool {
    lhs.id == rhs.id && lhs.name == rhs.name ? true : false
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }
  
  let id: String
  let image: AnyView
  let name: String
  let address: String
}

struct BookingItem: Identifiable, Hashable {
  static func == (lhs: BookingItem, rhs: BookingItem) -> Bool {
    lhs.id == rhs.id && lhs.name == rhs.name ? true : false
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }
  
  let id: String
  let image: AnyView
  let name: String
  let address: String
}

struct HistoryView: View {
  
  @StateObject var viewModel = HistoryViewModel()
  
  var body: some View {
    let recentBookings = viewModel.recentBookings
    let bookings = viewModel.bookings
    
    GeometryReader { geo in
      VStack(spacing: 0) {
        // HEADER
        CustomerHeaderView(id: "qwerty")
        
        // SEARCH
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: 0) {
            HStack {
              Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .font(.headline)
              
              Text("ค้นหา...")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.black)
              
              Spacer()
            }
            .padding()
            .frame(width: geo.size.width - 40, height: 44)
            .background(Color("LightGray"))
            .clipShape(Capsule())
            .padding()
            .background(.white)
            
            // LAST VISITED SHOPS
            VStack(alignment: .leading) {
              Text("ร้านตัดผมล่าสุด")
                .font(.custom("Noto Sans Thai", size: 18))
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .padding(.horizontal, 20)
              
              ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                  ForEach(recentBookings) { booking in
                    NavigationLink(value: AnyHashable(booking)) {
                      RecentBookingItemView(recentBooking: booking)
                    }
                  }
                }
                .padding(.horizontal, 4)
                .padding(.bottom, 16)
                .padding(.horizontal)
              }
            }
            
            Text("จองคิวตัดผม")
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundStyle(.black)
              .fontWeight(.medium)
              .padding()
              .frame(width: geo.size.width, height: 39, alignment: .leading)
              .background(.blueApp)
          }
          .background(.white)
          
          // RESERVATION
          VStack(alignment: .leading) {
            ForEach(bookings) { booking in
              NavigationLink(value: AnyHashable(booking)) {
                BookingItemView(booking: booking, width: geo.size.width)
              }
            }
          }
        }
        .background(.lightGray)
      }
    }
    .ignoresSafeArea()
    .task {
      await viewModel.fetch()
    }
    .task {
      await viewModel.fetchRecentBookings()
    }
  }
}

#Preview {
  HistoryView()
}

struct RecentBookingItemView: View {
  
  let recentBooking: RecentBookingItem
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      recentBooking.image
      //        .resizable()
      //        .aspectRatio(contentMode: .fill)
        .frame(width: 131, height: 90)
        .clipped()
      
      Text(recentBooking.name)
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.black)
        .padding(.horizontal, 6)
      
      HStack(alignment: .top, spacing: 0) {
        Image("Location")
          .padding(.leading, 4)
        Text(recentBooking.address)
          .font(.custom("Noto Sans Thai", size: 11))
          .foregroundStyle(.gray)
          .lineLimit(3)
      }
      
      Spacer()
    }
    .frame(width: 131, height: 181)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 4)
  }
}

struct BookingItemView: View {
  let booking: BookingItem
  let width: Double
  
  var body: some View {
    HStack(spacing: 16) {
      booking.image
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
    .background(.white)
  }
}
