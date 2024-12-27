//
//  AlamofireBalanceAccountService.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Alamofire
import Foundation

// MARK: - AlamofireBalanceAccountItemListFetchingService

class AlamofireBalanceAccountItemListFetchingService: BalanceAccountItemListFetchingService {

  // MARK: Lifecycle


  init(baseURL: String, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }

  // MARK: Internal

  func fetchBalanceAccountItemList() async throws -> [BalanceAccountItem] {
    let token = try await tokenManager.getFirebaseAuthToken()

    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
    ]

    let response = try await AF.request(
      "\(baseURL)/shops/balance-info-items",
      method: .get,
      headers: headers)
      .serializingDecodable(RemoteResponse<[RemoteBalanceAccountItem]>.self)
      .value

    if let error = response.error {
      throw NSError(domain: error, code: -1)
    }

    return response.data?.map { item in
      BalanceAccountItem(
        title: item.title,
        value: item.value,
        style: item.style.toLocalStyle())
    } ?? []
  }

  // MARK: Private

  private let baseURL: String
  private let tokenManager: FirebaseTokenManager
}

// MARK: - RemoteBalanceAccountItem

struct RemoteBalanceAccountItem: Decodable {
  let title: String
  let value: String
  let style: RemoteBalanceAccountItemStyle
}

// MARK: - RemoteBalanceAccountItemStyle

enum RemoteBalanceAccountItemStyle: String, Decodable {
  case regular = "REGULAR"
  case positive = "POSITIVE"
  case negative = "NEGATIVE"
  case bold = "BOLD"

  func toLocalStyle() -> BalanceAccountItemStyle {
    switch self {
    case .regular:
      return .regular
    case .positive:
      return .positive
    case .negative:
      return .negative
    case .bold:
      return .bold
    }
  }
}
