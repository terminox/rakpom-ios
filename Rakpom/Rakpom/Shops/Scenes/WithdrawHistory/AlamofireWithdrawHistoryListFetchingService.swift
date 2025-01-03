//
//  AlamofireWithdrawRequestService.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Alamofire
import Foundation

// MARK: - RemoteWithdrawHistoryItem

struct RemoteWithdrawHistoryItem: Codable {
  let title: String
  let dateString: String
  let formattedAmount: String
}

// MARK: - AlamofireWithdrawHistoryListFetchingService

class AlamofireWithdrawHistoryListFetchingService: WithdrawHistoryListFetchingService {

  // MARK: Lifecycle

  init(baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func fetch() async throws -> [WithdrawHistoryItem] {
    do {
      let token = try await tokenManager.getFirebaseAuthToken()

      let headers: HTTPHeaders = [
        "Authorization": "Bearer \(token)",
      ]

      let response = try await AF.request(
        baseURL.appendingPathComponent("shops/withdraw-requests"),
        method: .get,
        headers: headers)
        .serializingDecodable(RemoteResponse<[RemoteWithdrawHistoryItem]>.self)
        .value

      if let error = response.error {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
      }

      return response.data?.map { item in
        WithdrawHistoryItem(
          id: UUID().uuidString,
          title: item.title,
          dateString: item.dateString,
          amountString: item.formattedAmount)
      } ?? []
    } catch {
      throw error
    }
  }

  // MARK: Private

  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
}
