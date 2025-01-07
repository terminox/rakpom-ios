//
//  AggregatedUserProfileUpdatingService.swift
//  Rakpom
//
//  Created by yossa on 5/1/2568 BE.
//

import Foundation

// MARK: - AggregatedUserProfileUpdatingService

class AggregatedUserProfileUpdatingService: UserProfileUpdatingService {

  // MARK: Lifecycle

  init(baseURL: URL, tokenManager: FirebaseTokenManager, imageUploadingService: ImageUploadingService) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
    self.imageUploadingService = imageUploadingService
  }

  // MARK: Internal

  func updateProfile(payload: UserSignupPayload) async throws {
    let uri = try await imageUploadingService.uploadImage(payload.imageData)
    let token = try await tokenManager.getFirebaseAuthToken()

    var request = URLRequest(url: baseURL.appendingPathComponent("users/profiles/me"))
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let json: [String: Any] = [
      "avatarURL": uri.absoluteString,
      "fullName": payload.fullName,
      "gender": payload.gender.remoteValue,
      "age": payload.age,
      "phone": payload.phone,
      "email": payload.email ?? "",
    ]

    request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
      throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to update profile"])
    }
  }

  // MARK: Private

  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
  private let imageUploadingService: ImageUploadingService
}

extension Gender {
  var remoteValue: String {
    switch self {
    case .male: "male"
    case .female: "female"
    }
  }
}

// MARK: - ImageUploadingService

protocol ImageUploadingService {
  func uploadImage(_ imageData: Data) async throws -> URL
}
