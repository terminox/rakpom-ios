//
//  AggregatedQRPaymentService.swift
//  Rakpom
//
//  Created by yossa on 8/12/2567 BE.
//

import Foundation

class AggregatedQRPaymentService: QRPaymentService {

  // MARK: Lifecycle

  init(baseURL: URL, tokenManager: FirebaseTokenManager, imageUploadingService: ImageUploadingService) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
    self.imageUploadingService = imageUploadingService
  }

  // MARK: Internal

  func submitQRPayment(payload: QRPaymentPayload) async throws {
    do {
      let uri = try await imageUploadingService.uploadImage(payload.payslipImageData)
      let token = try await tokenManager.getFirebaseAuthToken()

      var request = URLRequest(url: baseURL.appendingPathComponent("users/payment/qr"))
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

      let json: [String: Any] = [
        "imageURL": uri.absoluteString,
        "amount": payload.amount,
        "shopCode": payload.shopCode,
      ]

      request.httpBody = try JSONSerialization.data(withJSONObject: json)

      let (_, response) = try await URLSession.shared.data(for: request)

      guard
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 201 else {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to submit payment"])
      }
    } catch {
      throw error
    }
  }

  // MARK: Private

  // MARK: - Properties

  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
  private let imageUploadingService: ImageUploadingService
}
