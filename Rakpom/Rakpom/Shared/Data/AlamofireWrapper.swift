//
//  AlamofireWrapper.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import Alamofire
import Foundation

class RakpomAlamofireWrapper {

  // MARK: Lifecycle

  init(tokenManager: FirebaseTokenManager) {
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  let tokenManager: FirebaseTokenManager

  func perform<T: Decodable>(_ request: DataRequest) async throws -> T {
    let response = try await request
      .validate()
      .serializingDecodable(RemoteResponse<T>.self)
      .response.result.get()

    if let errorMessage = response.error {
      throw RemoteError(message: errorMessage)
    }

    guard let data = response.data else {
      throw MissingRemoteDataError()
    }

    return data
  }

  func perform(_ request: DataRequest) async throws {
    let response = await request
      .validate()
      .serializingData()
      .response

    guard let statusCode = response.response?.statusCode, (200...299).contains(statusCode) else {
      throw MissingRemoteDataError()
    }
  }

  func getRequest(from url: URL) async throws -> DataRequest {
    let token = try await tokenManager.getFirebaseAuthToken()
    let headers = HTTPHeaders([
      .init(name: "Authorization", value: "Bearer \(token)"),
    ])
    return AF.request(
      url,
      method: .get,
      headers: headers,
      interceptor: .retryPolicy)
  }

  func postRequest(from url: URL, body: Encodable) async throws -> DataRequest {
    let token = try await tokenManager.getFirebaseAuthToken()
    let headers = HTTPHeaders([
      .init(name: "Content-Type", value: "application/json"),
      .init(name: "Authorization", value: "Bearer \(token)"),
    ])
    return AF.request(
      url,
      method: .post,
      parameters: body,
      encoder: JSONParameterEncoder.default,
      headers: headers,
      interceptor: .retryPolicy)
  }

  func patchRequest(from url: URL, body: Encodable) async throws -> DataRequest {
    let token = try await tokenManager.getFirebaseAuthToken()
    let headers = HTTPHeaders([
      .init(name: "Content-Type", value: "application/json"),
      .init(name: "Authorization", value: "Bearer \(token)"),
    ])
    return AF.request(
      url,
      method: .patch,
      parameters: body,
      encoder: JSONParameterEncoder.default,
      headers: headers,
      interceptor: .retryPolicy)
  }
}
