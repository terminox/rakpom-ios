//
//  ShopProfileFormViewModel.swift
//  Rakpom
//
//  Created by yossa on 5/1/2568 BE.
//

import Foundation

// MARK: - ShopProfileFormViewModel

class ShopProfileFormViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: ShopProfileService, onComplete: @escaping () -> Void) {
    self.service = service
    self.onComplete = onComplete
  }

  // MARK: Internal

  @Published var isLoading = false

  @MainActor
  func submit(payload: ShopProfilePayload) async {
    isLoading = true
    
    defer {
      isLoading = false
    }
    
    try? await service.updateShopProfile(payload: payload)
    onComplete()
  }

  // MARK: Private

  private let service: ShopProfileService
  private let onComplete: () -> Void

}

// MARK: - ShopProfileService

protocol ShopProfileService {
  func updateShopProfile(payload: ShopProfilePayload) async throws
}

// MARK: - ShopProfilePayload

struct ShopProfilePayload {
  let name: String
  let ownerName: String
  let address: String
  let phone: String
  let bankName: String
  let bankAccountNumber: String
  let openingHours: String
  let imageData: Data
}
