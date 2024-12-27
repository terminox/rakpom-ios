//
//  AlamofireBookingRequestCreatingService.swift
//  Rakpom
//
//  Created by yossa on 27/12/2567 BE.
//

import Alamofire
import Foundation

// MARK: - RemoteBookingConfirmationDetailItem

struct RemoteBookingConfirmationDetailItem: Codable {
  let title: String
  let value: String
}

// MARK: - AlamofireBookingRequestCreatingService

class AlamofireBookingRequestCreatingService: BookingRequestCreatingService {

  // MARK: Lifecycle

  // MARK: - Initialization

  init(shopID: String, baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.shopID = shopID
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  // MARK: - BookingRequestCreatingService

  func createBookingRequest(payload: ShopDetailBookingPayload) async throws -> [BookingConfirmationDetailItem] {
    let token = try await tokenManager.getFirebaseAuthToken()

    let parameters: [String: Any] = [
      "shopID": shopID,
      "date": payload.millisSince1970,
      "startHour": payload.startHour,
      "startMinute": payload.startMinute,
    ]

    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json",
    ]

    let url = baseURL.appending(path: "users/booking-requests")

    let response = try await AF.request(
      url,
      method: .post,
      parameters: parameters,
      encoding: JSONEncoding.default,
      headers: headers)
      .serializingDecodable(RemoteResponse<[RemoteBookingConfirmationDetailItem]>.self)
      .value

    if let error = response.error {
      throw NSError(domain: error, code: -1)
    }

    return response.data?.map { item in
      BookingConfirmationDetailItem(title: item.title, value: item.value)
    } ?? []
  }

  // MARK: Private

  // MARK: - Properties

  private let shopID: String
  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
}
