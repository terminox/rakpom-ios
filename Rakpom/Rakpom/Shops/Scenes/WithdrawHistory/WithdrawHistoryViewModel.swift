//
//  WithdrawListViewModel.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Foundation

// MARK: - WithdrawHistoryViewModel

@MainActor
class WithdrawHistoryViewModel: ObservableObject {

  // MARK: Lifecycle

  init(withdrawHistoryListFetchingService: WithdrawHistoryListFetchingService) {
    self.withdrawHistoryListFetchingService = withdrawHistoryListFetchingService
    Task {
      await fetchItems()
    }
  }

  // MARK: Internal

  @Published private(set) var items: [WithdrawHistoryItem] = []

  // MARK: Private

  private let withdrawHistoryListFetchingService: WithdrawHistoryListFetchingService

  @MainActor
  func fetchItems() async {
    items = (try? await withdrawHistoryListFetchingService.fetch()) ?? []
  }
}

// MARK: - WithdrawHistoryItem

struct WithdrawHistoryItem: Identifiable {
  let id: String
  let title: String
  let dateString: String
  let amountString: String
}

// MARK: - WithdrawHistoryListFetchingService

protocol WithdrawHistoryListFetchingService {
  func fetch() async throws -> [WithdrawHistoryItem]
}
