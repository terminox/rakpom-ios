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
  let recentBookings: [RecentBookingItem] = [
    RecentBookingItem(id: "12345", image: AnyView(Image("Barber1")), name: "Rakpom", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
    RecentBookingItem(id: "44445", image: AnyView(Image("Barber2")), name: "Rakchan", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
    RecentBookingItem(id: "16754", image: AnyView(Image("Barber3")), name: "Rakter", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
  ]
  
  let bookings: [BookingItem] = [
    BookingItem(id: "12345", image: AnyView(Image("Barber1")), name: "Rakpom", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
    BookingItem(id: "44445", image: AnyView(Image("Barber2")), name: "Rakchan", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
    BookingItem(id: "16754", image: AnyView(Image("Barber3")), name: "Rakter", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
  ]
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        // HEADER
        CustomerHeaderView(id: "qwerty")
        
        // SEARCH
        ScrollView(.vertical, showsIndicators: false) {
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
          
          // LAST VISITED SHOPS
          VStack(alignment: .leading) {
            Text("ร้านตัดผมล่าสุด")
              .font(.custom("Noto Sans Thai", size: 18))
              .fontWeight(.medium)
              .foregroundStyle(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(recentBookings) { booking in
                  NavigationLink(value: AnyHashable(booking)) {
                    RecentBookingItemView()
                  }
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
              NavigationLink(value: AnyHashable(booking)) {
                BookingItemView(index: 1, width: geo.size.width)
              }
            }
          }
          .background(Color("LightGray"))
        }
      }
    }
//    .padding(.bottom, 100)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  HistoryView()
}

struct RecentBookingItemView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Image("Barber1")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 131, height: 90)
        .clipped()
      
      Text("ช่างชุ่ย")
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.black)
        .padding(.horizontal, 6)
      
      HStack(alignment: .top, spacing: 0) {
        Image("Location")
          .padding(.leading, 4)
        Text("35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
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
  let index: Int
  let width: Double

  var body: some View {
    HStack(spacing: 16) {
      Image("Barber\(index + 2)")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: width / 3, height: 82)
        .clipShape(RoundedRectangle(cornerRadius: 4))
      
      VStack(alignment: .leading, spacing: 8) {
        Text("ร้านลุงหนุ่ม")
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)
        
        HStack(alignment: .firstTextBaseline, spacing: 0) {
          Image("Location")

          Text("35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
            .font(.custom("Noto Sans Thai", size: 13))
            .foregroundStyle(.gray)
            .lineLimit(3)
            .padding(.horizontal, 4)
        }
      }
    }
    .padding(.horizontal)
    .frame(width: width, height: 97)
    .background(.white)
  }
}
