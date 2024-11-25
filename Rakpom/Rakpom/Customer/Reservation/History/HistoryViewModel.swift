//
//  HistoryViewModel.swift
//  Rakpom
//
//  Created by yossa on 31/8/2567 BE.
//

import Foundation
import SwiftUI

class HistoryViewModel: ObservableObject {
  let recentBookings: [RecentBookingItem] = [
    RecentBookingItem(id: "12345", image: AnyView(Image("Barber1")), name: "Rakpom", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
    RecentBookingItem(id: "44445", image: AnyView(Image("Barber2")), name: "Rakchan", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
    RecentBookingItem(id: "16754", image: AnyView(Image("Barber3")), name: "Rakter", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
  ]
  
//  let bookings: [BookingItem] = [
//    BookingItem(id: "12345", image: AnyView(Image("Barber1")), name: "Rakpom", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
//    BookingItem(id: "44445", image: AnyView(Image("Barber2")), name: "Rakchan", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900"),
//    BookingItem(id: "16754", image: AnyView(Image("Barber3")), name: "Rakter", address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
//  ]
  
  @Published var bookings: [BookingItem] = []
  
  func fetch() async {
    let session = URLSession(configuration: .ephemeral)
    let url = URL(string: "http://localhost:8000/api/v1/users/shops/pages?offset=0&limit=20")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMDFKNE1EWjdUMTgwSFQ1OTZGOFI1RTJQMU4iLCJlbWFpbCI6InRlc3QxQHJha3BvbS5kZXYiLCJtZW1iZXJJRCI6IjEiLCJmdWxsTmFtZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJwaG9uZU51bWJlciI6bnVsbH0sImlhdCI6MTcyMjk2Nzg1M30.jwFbYPpfDlATDBSe4A7guaNkTVMzWnicGqmLud2Bc0o", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await session.data(for: urlRequest)
      print("data: ", data)
      let decoder = JSONDecoder()
      let response = try decoder.decode(LegacyRemoteResponse.self, from: data)
      
      if let errorMessage = response.error {
        print(errorMessage)
        return
      }
      
      if let remoteShops = response.data {
        for remoteShop in remoteShops {
          let image = AnyView(
            AsyncImage(
              url: remoteShop.imageURL,
              content: { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              },
              placeholder: {
                EmptyView()
              }
            )
          )

          bookings.append(BookingItem(
            id: remoteShop.id,
            image: image,
            name: remoteShop.name,
            address: remoteShop.address
          ))
        }
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct LegacyRemoteResponse: Decodable {
  let data: [RemoteShop]?
  let error: String?
}

struct RemoteShop: Decodable {
  let id: String
  let name: String
  let imageURL: URL
  let address: String
}
