//
//  AlamofirePointPaymentService.swift
//  Rakpom
//
//  Created by yossa on 15/12/2567 BE.
//

import Alamofire
import Foundation

class AlamofirePointPaymentService: PointPaymentService {
  
  // MARK: Lifecycle
  
  init(baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }
  
  // MARK: Internal
  
  func submit(payload: PointPaymentPayload) async throws {
    let token = try await tokenManager.getFirebaseAuthToken()
    
    let parameters: [String: Any] = [
      "points": payload.points,
      "shopCode": payload.shopCode
    ]
    
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json"
    ]
    
    let url = baseURL.appendingPathComponent("/users/payment/points")
    
    let response = await AF.request(
      url,
      method: .post,
      parameters: parameters,
      encoding: JSONEncoding.default,
      headers: headers)
      .serializingDecodable(EmptyResponse.self)
      .response
    
    guard response.response?.statusCode == 201 else {
      throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to submit payment"])
    }
  }
  
  // MARK: Private
  
  private struct EmptyResponse: Decodable {}
  
  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
  
}
