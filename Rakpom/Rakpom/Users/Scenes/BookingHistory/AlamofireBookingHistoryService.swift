//
//  AlamofireBookingHistoryService.swift
//  Rakpom
//
//  Created by yossa on 29/11/2567 BE.
//

import Foundation

class AlamofireBookingHistoryService: BookingHistoryService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  let url: URL
  let client: RakpomAlamofireWrapper

  func fetchBookingHistory() async throws -> [BookingHistoryItem] {
    let request = try await client.getRequest(from: url)
    let items: [RemoteBookingHistoryItem] = try await client.perform(request)
    return items.map { $0.toLocal() }
  }

  // MARK: Private

  private struct RemoteBookingHistoryItem: Decodable {
    let id: String
    let shopName: String
    let location: String
    let description: String
    let points: Int
    let price: String
    let imageURL: URL

    func toLocal() -> BookingHistoryItem {
      .init(
        id: id,
        name: shopName,
        location: location,
        description: description,
        points: points,
        price: price,
        imageURL: imageURL)
    }
  }
}
