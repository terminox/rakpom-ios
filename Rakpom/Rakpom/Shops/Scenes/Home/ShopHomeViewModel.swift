//
//  ShopHomeViewModel.swift
//  Rakpom
//
//  Created by yossa on 12/1/2568 BE.
//

import Foundation

// MARK: - ShopHomeViewModel

class ShopHomeViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any ShopHomeService) {
    self.service = service
  }

  // MARK: Internal

  @Published var item: ShopHomeDetailItem?
  @Published var isLoading = false
  @Published var error: Error?

  func onAppear() {
    Task { @MainActor in
      await fetchShopHome()
    }
  }

  @MainActor
  func fetchShopHome() async {
    isLoading = true
    error = nil

    do {
      item = try await service.fetchShopHomeItem()
    } catch {
      self.error = error
    }

    isLoading = false
  }

  // MARK: Private

  private let service: any ShopHomeService

}

// MARK: - ShopHomeService

protocol ShopHomeService {
  func fetchShopHomeItem() async throws -> ShopHomeDetailItem
}

// MARK: - ShopHomeDetailItem

struct ShopHomeDetailItem {
  let coverImageURL: URL
  let telNo: String
  let address: String
}
