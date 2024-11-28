//
//  ShopListViewModel.swift
//  Rakpom
//
//  Created by yossa on 31/8/2567 BE.
//

import Foundation
import SwiftUI

// MARK: - ShopListViewModel

class ShopListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(
    recentBookingService: any RecentBookingService,
    shopListService: any ShopListService,
    onShopSelected: @escaping (ShopItem) -> Void)
  {
    self.recentBookingService = recentBookingService
    self.shopListService = shopListService
    self.onShopSelected = onShopSelected
  }

  // MARK: Internal

  let recentBookingService: any RecentBookingService
  let shopListService: any ShopListService
  let onShopSelected: (ShopItem) -> Void

  @Published var recentBookings: [ShopItem] = []
  @Published var shops: [ShopItem] = []


  func select(_: ShopItem) {

  }

  @MainActor
  func fetch() async {
    recentBookings = (try? await recentBookingService.fetchRecentBookings()) ?? []
    shops = (try? await shopListService.fetchShopList()) ?? []
  }
}

// MARK: - ShopListService

protocol ShopListService {
  func fetchShopList() async throws -> [ShopItem]
}

// MARK: - RecentBookingService

protocol RecentBookingService {
  func fetchRecentBookings() async throws -> [ShopItem]
}

// MARK: - ShopItem

struct ShopItem: Identifiable, Hashable {
  let id: String
  let imageURL: URL
  let name: String
  let address: String
}
