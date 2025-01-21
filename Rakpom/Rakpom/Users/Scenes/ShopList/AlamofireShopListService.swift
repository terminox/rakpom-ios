//
//  AlamofireShopListService.swift
//  Rakpom
//
//  Created by yossa on 28/11/2567 BE.
//

import Foundation
import SwiftUI

// MARK: - RemoteShop

struct RemoteShop: Decodable {
  let id: String
  let name: String?
  let imageURL: URL?
  let address: String?

  func toLocal() -> ShopItem? {
    guard let imageURL, let name, let address else { return nil }
    return .init(id: id, imageURL: imageURL, name: name, address: address)
  }
}

// MARK: - AlamofireShopListService

class AlamofireShopListService: ShopListService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  let url: URL
  let client: RakpomAlamofireWrapper

  // MARK: - RemoteShop

  func fetchShopList() async throws -> [ShopItem] {
    do {
      let request = try await client.getRequest(from: url)
      let items: [RemoteShop] = try await client.perform(request)
      return items
        .map { $0.toLocal() }
        .compactMap { $0 }
    } catch {
      print(error)
      throw error
    }
  }
}

// MARK: - AlamofireRecentBookingService

class AlamofireRecentBookingService: RecentBookingService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  let url: URL
  let client: RakpomAlamofireWrapper

  // MARK: - RemoteShop

  func fetchRecentBookings() async throws -> [ShopItem] {
    let request = try await client.getRequest(from: url)
    let items: [RemoteShop] = try await client.perform(request)
    return items
      .map { $0.toLocal() }
      .compactMap { $0 }
  }
}
