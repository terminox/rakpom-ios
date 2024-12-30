//
//  AlamofirePointListService.swift
//  Rakpom
//
//  Created by yossa on 30/12/2567 BE.
//

import Alamofire
import Foundation

// MARK: - AlamofirePointListService

class AlamofirePointListService: PointListService {

  // MARK: Lifecycle

  init(baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func fetchPointsUserProfile() async throws -> PointsUserProfile {
    let remoteProfile = try await fetchRemoteUserProfile()
    let profile = PointsUserProfile(
      avatarURL: remoteProfile.avatarURL ?? URL(string: "http://example.com")!,
      fullName: remoteProfile.fullName ?? "",
      memberID: remoteProfile.memberID ?? "",
      totalPoints: remoteProfile.totalPoints,
      points: remoteProfile.points.map {
        ProfilePoint(id: UUID().uuidString, point: $0.value, dateString: $0.dateString)
      })
    return profile
  }

  // MARK: Private

  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager

  private func fetchRemoteUserProfile() async throws -> RemoteUserProfile {
    let token = try await tokenManager.getFirebaseAuthToken()
    let request = AF.request(
      baseURL.appendingPathComponent("users/profiles/me"),
      headers: ["Authorization": "Bearer \(token)"])
    let data = try await request.serializingData().value
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let response = try decoder.decode(RemoteResponse<RemoteUserProfile>.self, from: data)

    if let error = response.error {
      throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error])
    }

    guard let data = response.data else {
      throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data found"])
    }

    return data
  }
}

// MARK: - RemoteUserProfile

struct RemoteUserProfile: Codable {
  let id: String
  let email: String
  let memberID: String?
  let fullName: String?
  let gender: String?
  let phoneNumber: String?
  let avatarURL: URL?
  let totalPoints: Int
  let points: [RemoteProfilePoint]
}

// MARK: - RemoteProfilePoint

struct RemoteProfilePoint: Codable {
  let value: Int
  let dateString: String
}
