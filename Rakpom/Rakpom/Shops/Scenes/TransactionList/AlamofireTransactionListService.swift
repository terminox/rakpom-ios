//
//  AlamofireTransactionListService.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Alamofire
import Foundation

class AlamofireTransactionListService: ShopTransactionListFetchingService {
  
  // MARK: Lifecycle
  
  init(baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }
  
  // MARK: Internal
  
  func fetchTransactionList() async throws -> [TransactionItem] {
    let token = try await tokenManager.getFirebaseAuthToken()
    
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
    ]
    
    let response = try await AF.request(
      baseURL.appending(path: "shops/transactions"),
      method: .get,
      headers: headers)
      .serializingDecodable(RemoteResponse<[RemoteTransactionItem]>.self)
      .value
    
    if let error = response.error {
      throw NSError(domain: error, code: -1)
    }
    
    return response.data?.map { item in
      TransactionItem(
        id: item.id,
        title: item.title,
        description: item.description,
        dateString: item.dateString,
        amount: item.amount,
        amountString: item.amountString
      )
    } ?? []
  }
  
  // MARK: Private
  
  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager
}

// MARK: - RemoteTransactionItem

struct RemoteTransactionItem: Decodable {
  let id: String
  let title: String
  let description: String
  let dateString: String
  let amount: Int
  let amountString: String
}
