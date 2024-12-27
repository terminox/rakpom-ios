//
//  AlamofireReviewListService.swift
//  Rakpom
//
//  Created by yossa on 25/12/2567 BE.
//

import Alamofire
import Foundation

// MARK: - AlamofireShopReviewListService

class AlamofireShopReviewListService: ShopReviewListFetchingService {

  // MARK: Lifecycle

  init(endpointURL: URL, tokenManager: FirebaseTokenManager) {
    self.endpointURL = endpointURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func fetchShopReviewList() async throws -> [ShopReviewItem] {
    let token = try await tokenManager.getFirebaseAuthToken()

    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
    ]

    let response = try await AF.request(
      endpointURL,
      method: .get,
      headers: headers)
      .serializingDecodable(RemoteResponse<[RemoteShopReviewItem]>.self)
      .value

    if let error = response.error {
      throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
    }

    return response.data?.map { item in
      ShopReviewItem(
        id: item.id,
        reviewerName: item.reviewerName,
        score: item.score,
        text: item.text,
        dateString: item.dateString,
        reviewerImageURL: item.reviewerImageURL)
    } ?? []
  }

  // MARK: Private

  private let endpointURL: URL
  private let tokenManager: FirebaseTokenManager
}

// MARK: - RemoteShopReviewItem

struct RemoteShopReviewItem: Codable {
  let id: String
  let reviewerName: String
  let score: Int
  let text: String
  let dateString: String
  let reviewerImageURL: URL
}
