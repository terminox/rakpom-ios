//
//  BookingHistoryViewModel.swift
//  Rakpom
//
//  Created by yossa on 29/11/2567 BE.
//

import Foundation

// MARK: - BookingHistoryViewModel

class BookingHistoryViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any BookingHistoryService) {
    self.service = service
  }

  // MARK: Internal

  let service: any BookingHistoryService

  @Published var items: [BookingHistoryItem] = []

  @MainActor
  func fetch() async {
    items = (try? await service.fetchBookingHistory()) ?? []
  }
}

// MARK: - BookingHistoryService

protocol BookingHistoryService {
  func fetchBookingHistory() async throws -> [BookingHistoryItem]
}

// MARK: - BookingHistoryItem

struct BookingHistoryItem: Identifiable {
  let id: String
  let name: String
  let location: String
  let description: String
  let points: Int
  let price: String
  let imageURL: URL
}
