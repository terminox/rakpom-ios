//
//  BalanceAccountViewModel.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Combine
import Foundation

// MARK: - BalanceAccountViewModel

class BalanceAccountViewModel: ObservableObject {

  // MARK: Lifecycle

  init(
    balanceAccountItemListFetchingService: BalanceAccountItemListFetchingService,
    withdrawRequestService: ShopWithdrawRequestService)
  {
    self.balanceAccountItemListFetchingService = balanceAccountItemListFetchingService
    self.withdrawRequestService = withdrawRequestService
  }

  // MARK: Internal

  @Published private(set) var items: [BalanceAccountItem] = []
  
  func onAppear() {
    Task { @MainActor in
      await fetchBalanceInfo()
    }
  }

  @MainActor
  func withdraw() async {
    _ = try? await withdrawRequestService.createWithdrawRequest()
  }

  // MARK: Private

  private let balanceAccountItemListFetchingService: BalanceAccountItemListFetchingService
  private let withdrawRequestService: ShopWithdrawRequestService

  @MainActor
  private func fetchBalanceInfo() async {
    do {
      let result = try await balanceAccountItemListFetchingService.fetchBalanceAccountItemList()
      items = result
    } catch {
      // Handle error
    }
  }
}

// MARK: - BalanceAccountItemListFetchingService

protocol BalanceAccountItemListFetchingService {
  func fetchBalanceAccountItemList() async throws -> [BalanceAccountItem]
}

// MARK: - ShopWithdrawRequestService

protocol ShopWithdrawRequestService {
  func createWithdrawRequest() async throws -> WithdrawRequestResult
}

// MARK: - BalanceAccountItem

struct BalanceAccountItem: Identifiable {
  let title: String
  let value: String
  let style: BalanceAccountItemStyle
  
  var id: String {
    title + value
  }
}

// MARK: - BalanceAccountItemStyle

enum BalanceAccountItemStyle {
  case regular
  case positive
  case negative
  case bold
}

// MARK: - WithdrawRequestResult

struct WithdrawRequestResult {
  let id: String
  let amount: Double
}
