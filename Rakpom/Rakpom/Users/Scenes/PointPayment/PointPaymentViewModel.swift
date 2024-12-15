//
//  PointPaymentViewModel.swift
//  Rakpom
//
//  Created by yossa on 15/12/2567 BE.
//

import Foundation

class PointPaymentViewModel: ObservableObject {
  
  // MARK: Lifecycle
  
  init(service: PointPaymentService, onCompleted: @escaping (String) -> Void = { _ in }) {
    self.service = service
    self.onCompleted = onCompleted
  }
  
  // MARK: Internal
  
  @Published var isLoading = false
  
  @MainActor
  func submit(payload: PointPaymentPayload) async {
    isLoading = true
    
    do {
      try await service.submit(payload: payload)
      onCompleted(payload.shopCode)
    } catch {
      print("PointPaymentViewModel error: \(error)")
    }
    
    isLoading = false
  }
  
  // MARK: Private
  
  private let service: PointPaymentService
  private let onCompleted: (String) -> Void
}

// MARK: - PointPaymentService

protocol PointPaymentService {
  func submit(payload: PointPaymentPayload) async throws
}

// MARK: - PointPaymentPayload

struct PointPaymentPayload {
  let points: String
  let shopCode: String
}
