//
//  QRPaymentViewModel.swift
//  Rakpom
//
//  Created by yossa on 8/12/2567 BE.
//

import Foundation

// MARK: - QRPaymentViewModel

class QRPaymentViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any QRPaymentService, onCompleted: @escaping (String) -> Void) {
    self.service = service
    self.onCompleted = onCompleted
  }

  // MARK: Internal

  @Published var isLoading = false

  @MainActor
  func submit(_ payload: QRPaymentPayload) async {
    isLoading = true

    do {
      try await service.submitQRPayment(payload: payload)
      onCompleted(payload.shopCode)
    } catch {
      print("QRPaymentViewModel error: \(error)")
    }

    isLoading = false
  }

  // MARK: Private

  private let service: any QRPaymentService
  private let onCompleted: (String) -> Void

}

// MARK: - QRPaymentService

protocol QRPaymentService {
  func submitQRPayment(payload: QRPaymentPayload) async throws
}

// MARK: - QRPaymentPayload

struct QRPaymentPayload {
  let amount: String
  let shopCode: String
  let payslipImageData: Data
}
