//
//  TransactionListViewModel.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Combine
import Foundation

class TransactionListViewModel: ObservableObject {
  
  // MARK: Lifecycle
  
  init(service: ShopTransactionListFetchingService) {
    self.service = service
  }
  
  // MARK: Internal
  
  @Published private(set) var items: [TransactionItem] = []
  
  func onAppear() {
    Task { @MainActor in
      await fetchTransactionList()
    }
  }
  
  // MARK: Private
  
  private let service: ShopTransactionListFetchingService
  
  @MainActor
  private func fetchTransactionList() async {
    do {
      let result = try await service.fetchTransactionList()
      items = result
    } catch {
      // Handle error
    }
  }
}

// MARK: - ShopTransactionListFetchingService

protocol ShopTransactionListFetchingService {
  func fetchTransactionList() async throws -> [TransactionItem]
}

// MARK: - TransactionItem

struct TransactionItem: Identifiable {
  let id: String
  let title: String
  let description: String
  let dateString: String
  let amount: Int
  let amountString: String
}
