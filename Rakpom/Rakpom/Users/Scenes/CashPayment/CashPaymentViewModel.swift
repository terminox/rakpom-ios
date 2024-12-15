//
//  CashPaymentViewModel.swift
//  Rakpom
//
//  Created by yossa on 15/12/2567 BE.
//

import Foundation

class CashPaymentViewModel: ObservableObject {
  
  // MARK: Lifecycle
  
  init(service: CashPaymentService, onCompleted: @escaping (String) -> Void = { _ in }) {
    self.service = service
    self.onCompleted = onCompleted
  }
  
  // MARK: Internal
  
  @Published var isLoading = false
  
  @MainActor
  func submit(amount: String, shopCode: String) async {
    isLoading = true
    
    do {
      try await service.submitPayment(amount: amount, shopCode: shopCode)
      onCompleted(shopCode)
    } catch {
      print("CashPaymentViewModel error: \(error)")
    }
    
    isLoading = false
  }
  
  // MARK: Private
  
  private let service: CashPaymentService
  private let onCompleted: (String) -> Void
  
}

// MARK: - CashPaymentService

protocol CashPaymentService {
  func submitPayment(amount: String, shopCode: String) async throws
}
