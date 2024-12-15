//
//  AlamofireFeedbackService.swift
//  Rakpom
//
//  Created by yossa on 15/12/2567 BE.
//

import Alamofire
import Foundation

class AlamofireFeedbackService: FeedbackService {

  // MARK: Lifecycle

  init(shopCode: String, url: URL, tokenManager: FirebaseTokenManager) {
    self.shopCode = shopCode
    self.url = url
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func submitFeedback(payload: FeedbackPayload) async throws {
    let token = try await tokenManager.getFirebaseAuthToken()

    let parameters: [String: Any] = [
      "shopCode": shopCode,
      "score": payload.score,
      "content": payload.content,
    ]

    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json",
    ]

    let response = await AF.request(
      url,
      method: .post,
      parameters: parameters,
      encoding: JSONEncoding.default,
      headers: headers)
      .serializingDecodable(EmptyResponse.self)
      .response

    guard response.response?.statusCode == 201 else {
      throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to submit feedback"])
    }
  }

  // MARK: Private

  private struct EmptyResponse: Decodable {}

  private let shopCode: String
  private let url: URL
  private let tokenManager: FirebaseTokenManager
}

