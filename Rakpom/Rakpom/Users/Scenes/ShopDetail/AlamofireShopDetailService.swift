//
//  AlamofireShopDetailService.swift
//  Rakpom
//
//  Created by yossa on 27/12/2567 BE.
//

import Foundation

import Alamofire

// MARK: - RemoteShopDetailItem

struct RemoteShopDetailItem: Codable {
  let id: String
  let name: String
  let ownerName: String
  let imageURL: URL
  let rating: Int
  let reviewCount: Int
  let phone: String
  let businessHours: String
  let address: String
}

// MARK: - AlamofireShopDetailService

class AlamofireShopDetailService: ShopDetailService {

  // MARK: Lifecycle

  init(id: String, baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.id = id
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func fetchShopDetail() async throws -> ShopDetail {
    do {
      let token = try await tokenManager.getFirebaseAuthToken()

      let headers: HTTPHeaders = [
        "Authorization": "Bearer \(token)",
      ]

      let url = baseURL.appending(path: "users/shops/\(id)")

      let response = try await AF.request(url, headers: headers)
        .serializingDecodable(RemoteResponse<RemoteShopDetailItem>.self)
        .value

      if let error = response.error {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
      }

      guard let data = response.data else {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])
      }

      return ShopDetail(
        name: data.name,
        coverImageURL: data.imageURL,
        rating: data.rating,
        reviewCount: data.reviewCount,
        tel: data.phone,
        businessHours: data.businessHours,
        address: data.address
      )
    } catch {
      throw error
    }
  }

  // MARK: Private

  private let id: String
  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
}
