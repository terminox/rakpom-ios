//
//  PrizeListViewModel.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import Foundation

// MARK: - PrizeListViewModel

class PrizeListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any PrizeListService) {
    self.service = service
  }

  // MARK: Internal

  let service: any PrizeListService

  @Published var items: [PrizeItem] = []

  @MainActor
  func fetch() async {
    items = (try? await service.fetchPrizeItems()) ?? []
  }
}

// MARK: - PrizeListService

protocol PrizeListService {
  func fetchPrizeItems() async throws -> [PrizeItem]
}

// MARK: - PrizeItem

struct PrizeItem: Identifiable {
  let title: String
  let value: String

  var id: String {
    title + value
  }
}
