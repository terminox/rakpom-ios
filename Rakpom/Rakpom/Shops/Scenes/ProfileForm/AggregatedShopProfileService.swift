//
//  AggregatedShopProfileService.swift
//  Rakpom
//
//  Created by yossa on 5/1/2568 BE.
//

import Foundation

class AggregatedShopProfileService: ShopProfileService {

  // MARK: Lifecycle

  init(baseURL: URL, tokenManager: FirebaseTokenManager, imageUploadingService: ImageUploadingService) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
    self.imageUploadingService = imageUploadingService
  }

  // MARK: Internal

  func updateShopProfile(payload: ShopProfilePayload) async throws {
    let uri = try await self.imageUploadingService.uploadImage(payload.imageData)
    let token = try await self.tokenManager.getFirebaseAuthToken()

    var request = URLRequest(url: self.baseURL.appendingPathComponent("shops/profiles/me"))
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let json: [String: Any] = [
      "name": payload.name,
      "ownerName": payload.ownerName,
      "address": payload.address,
      "phone": payload.phone,
      "bankName": payload.bankName,
      "bankAccountNumber": payload.bankAccountNumber,
      "openingHours": payload.openingHours,
      "imageURL": uri.absoluteString,
    ]

    request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])

    let (data, response) = try await URLSession.shared.data(for: request)

    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 204 {
      throw NSError(domain: "UpdateProfileError", code: httpResponse.statusCode, userInfo: nil)
    }
  }

  // MARK: Private

  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
  private let imageUploadingService: ImageUploadingService

}
