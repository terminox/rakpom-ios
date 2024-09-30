//
//  ReservationViewModel.swift
//  Rakpom
//
//  Created by yossa on 31/8/2567 BE.
//

import Foundation
import SwiftUI

struct BarberDataResponse: Codable {
    let data: BarberData?
    let error: String?
}

struct BarberData: Codable {
    let id: String
    let name: String
    let ownerName: String
    let phone: String
    let imageURL: URL
    let rating: Int
    let reviewCount: Int
    let address: String
    let businessHours: String
}

class ReservationViewModel: ObservableObject {
  
  @Published var shopDetail: ShopDetail?
  
  @MainActor
  func fetchShopDetail() async {
    let session = URLSession(configuration: .ephemeral)
    let url = URL(string: "https://e395-184-22-157-24.ngrok-free.app/api/v1/users/shops/01J4ME1JMG7N5NAH422Z510HWT")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMDFKNE1EWjdUMTgwSFQ1OTZGOFI1RTJQMU4iLCJlbWFpbCI6InRlc3QxQHJha3BvbS5kZXYiLCJtZW1iZXJJRCI6IjEiLCJmdWxsTmFtZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJwaG9uZU51bWJlciI6bnVsbH0sImlhdCI6MTcyMjk2Nzg1M30.jwFbYPpfDlATDBSe4A7guaNkTVMzWnicGqmLud2Bc0o", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await session.data(for: urlRequest)
      print("data: ", data)
      let decoder = JSONDecoder()
      let response = try decoder.decode(BarberDataResponse.self, from: data)
      
      if let errorMessage = response.error {
        print(errorMessage)
        return
      }
      
      if let barberShop = response.data {
        let image = AnyView(
          AsyncImage(
            url: barberShop.imageURL,
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
        
        self.shopDetail = ShopDetail(
          id: barberShop.id,
          name: barberShop.name,
          ownerName: barberShop.ownerName,
          phone: barberShop.phone,
          image: image,
          rating: barberShop.rating,
          reviewCount: barberShop.reviewCount,
          address: barberShop.address,
          businessHours: barberShop.businessHours
        )
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
