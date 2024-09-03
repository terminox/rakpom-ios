//
//  PointViewModel.swift
//  Rakpom
//
//  Created by CatMeox on 3/9/2567 BE.
//

import SwiftUI

struct ShopResponse: Decodable {
    let data: [Shop]?
    let error: String?
}

struct Shop: Decodable, Identifiable {
    let id: String
    let shopName: String
    let location: String
    let description: String
    let points: Int
    let price: String
    let imageURL: URL
}

class PointViewModel: ObservableObject {
  
  @Published var history: [ShopItem] = []
  
  @MainActor
  func fetchHistory() async {
    let session = URLSession(configuration: .ephemeral)
    let url = URL(string: "https://f166-184-22-191-39.ngrok-free.app/api/v1/users/booking_history_items/pages?offset=0&limit=20")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMDFKNE1EWjdUMTgwSFQ1OTZGOFI1RTJQMU4iLCJlbWFpbCI6InRlc3QxQHJha3BvbS5kZXYiLCJtZW1iZXJJRCI6IjEiLCJmdWxsTmFtZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJwaG9uZU51bWJlciI6bnVsbH0sImlhdCI6MTcyMjk2Nzg1M30.jwFbYPpfDlATDBSe4A7guaNkTVMzWnicGqmLud2Bc0o", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await session.data(for: urlRequest)
      print("data: ", data)
      let decoder = JSONDecoder()
      let response = try decoder.decode(ShopResponse.self, from: data)
      
      if let errorMessage = response.error {
        print(errorMessage)
        return
      }
      
      if let usage = response.data {
        var history: [ShopItem] = []
        
        for usage in usage {
          let image = AnyView(
            AsyncImage(
              url: usage.imageURL,
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
          
          history.append(ShopItem(
            id: usage.id,
            shopName: usage.shopName,
            location: usage.location,
            description: usage.description,
            points: usage.points,
            price: usage.price,
            image: image
          ))
        }
        
        self.history = history
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
