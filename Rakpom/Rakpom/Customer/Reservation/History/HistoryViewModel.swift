//
//  HistoryViewModel.swift
//  Rakpom
//
//  Created by yossa on 31/8/2567 BE.
//

import Foundation
import SwiftUI


struct RemoteResponse: Decodable {
  let data: [RemoteShop]?
  let error: String?
}

struct RemoteShop: Decodable {
  let id: String
  let name: String
  let imageURL: URL
  let address: String
}

class HistoryViewModel: ObservableObject {
  
  @Published var recentBookings: [RecentBookingItem] = []
  
  @Published var bookings: [BookingItem] = []
  
  @MainActor
  
  // RECENT BOOKINGS
  func fetchRecentBookings() async {
    let session = URLSession(configuration: .ephemeral)
    let url = URL(string: "https://f166-184-22-191-39.ngrok-free.app/api/v1/users/shops/recent")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMDFKNE1EWjdUMTgwSFQ1OTZGOFI1RTJQMU4iLCJlbWFpbCI6InRlc3QxQHJha3BvbS5kZXYiLCJtZW1iZXJJRCI6IjEiLCJmdWxsTmFtZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJwaG9uZU51bWJlciI6bnVsbH0sImlhdCI6MTcyMjk2Nzg1M30.jwFbYPpfDlATDBSe4A7guaNkTVMzWnicGqmLud2Bc0o", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await session.data(for: urlRequest)
      print("data: ", data)
      let decoder = JSONDecoder()
      let response = try decoder.decode(RemoteResponse.self, from: data)
      
      if let errorMessage = response.error {
        print(errorMessage)
        return
      }
      
      if let remoteShops = response.data {
        var recentBookings: [RecentBookingItem] = []
        
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

          recentBookings.append(RecentBookingItem(
            id: remoteShop.id,
            image: image,
            name: remoteShop.name,
            address: remoteShop.address
          ))
        }
        
        self.recentBookings = recentBookings
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // BOOKINGS
  func fetch() async {
    let session = URLSession(configuration: .ephemeral)
    let url = URL(string: "https://f166-184-22-191-39.ngrok-free.app/api/v1/users/shops/pages?offset=0&limit=20")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMDFKNE1EWjdUMTgwSFQ1OTZGOFI1RTJQMU4iLCJlbWFpbCI6InRlc3QxQHJha3BvbS5kZXYiLCJtZW1iZXJJRCI6IjEiLCJmdWxsTmFtZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJwaG9uZU51bWJlciI6bnVsbH0sImlhdCI6MTcyMjk2Nzg1M30.jwFbYPpfDlATDBSe4A7guaNkTVMzWnicGqmLud2Bc0o", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await session.data(for: urlRequest)
      print("data: ", data)
      let decoder = JSONDecoder()
      let response = try decoder.decode(RemoteResponse.self, from: data)
      
      if let errorMessage = response.error {
        print(errorMessage)
        return
      }
      
      if let remoteShops = response.data {
        var bookings: [BookingItem] = []
        
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
        
        self.bookings = bookings
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
