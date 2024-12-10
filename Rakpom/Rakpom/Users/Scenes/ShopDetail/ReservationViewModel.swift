//
//  ReservationViewModel.swift
//  Rakpom
//
//  Created by yossa on 31/8/2567 BE.
//

import Foundation

// MARK: - ReservationViewModel

class ReservationViewModel: ObservableObject {

  // MARK: Lifecycle
  
  init(service: any ShopDetailService) {
    self.service = service
  }

  // MARK: Internal
  
  @Published var detail: ShopDetail?
  @Published var isLoading = false
  @Published var error: Error?
  
  @MainActor
  func fetchShopDetail() async {
    isLoading = true
    error = nil
    
    do {
      detail = try await service.fetchShopDetail()
    } catch {
      self.error = error
    }
    
    isLoading = false
  }
  
  // MARK: Private
  
  private let service: any ShopDetailService

}

// MARK: - ShopDetailService

protocol ShopDetailService {
  func fetchShopDetail() async throws -> ShopDetail
}

// MARK: - ShopDetail

struct ShopDetail {
  let name: String
  let coverImageURL: URL
  let rating: Int
  let reviewCount: Int
  let tel: String
  let businessHours: String
  let address: String
}
