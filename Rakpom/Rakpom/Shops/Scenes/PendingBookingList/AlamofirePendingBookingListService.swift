//
//  AlamofirePendingBookingListService.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Alamofire
import Foundation

// MARK: - AlamofirePendingBookingListFetchingService

class AlamofirePendingBookingListFetchingService: PendingBookingListFetchingService {

  // MARK: Lifecycle

  init(baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func fetchPendingBookingList() async throws -> [PendingBookingItem] {
    let token = try await tokenManager.getFirebaseAuthToken()

    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
    ]

    let response = try await AF.request(
      baseURL.appending(path: "shops/booking-requests"),
      method: .get,
      headers: headers)
      .serializingDecodable(RemoteResponse<[RemoteBookingRequestItem]>.self)
      .value

    if let error = response.error {
      throw NSError(domain: error, code: -1)
    }

    return response.data?.map { item in
      PendingBookingItem(
        id: item.id,
        name: item.fullName,
        dateString: item.date,
        timeString: item.time,
        imageURL: item.imageURL
      )
    } ?? []
  }

  // MARK: Private

  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
  
}

// MARK: - RemoteBookingRequestItem

struct RemoteBookingRequestItem: Decodable {
  let id: String
  let fullName: String
  let date: String
  let time: String
  let imageURL: URL
}
