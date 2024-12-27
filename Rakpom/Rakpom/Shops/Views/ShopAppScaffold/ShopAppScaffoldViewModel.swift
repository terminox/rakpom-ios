//
//  ShopAppScaffoldViewModel.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import Foundation

// MARK: - ShopAppScaffoldViewModel

class ShopAppScaffoldViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any ShopAppScaffoldService) {
    self.service = service
  }

  // MARK: Internal

  let service: any ShopAppScaffoldService

  @Published var shop: AppScaffoldShop?

  @MainActor
  func fetch() async {
    shop = try? await service.fetchShop()
  }
}

// MARK: - ShopAppScaffoldService

protocol ShopAppScaffoldService {
  func fetchShop() async throws -> AppScaffoldShop
}

// MARK: - AppScaffoldShop

struct AppScaffoldShop {
  let name: String
  let avatarURL: URL
  let shopCode: String
}
