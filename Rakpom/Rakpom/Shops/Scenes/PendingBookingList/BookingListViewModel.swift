//
//  BookingListViewModel.swift
//  Rakpom
//
//  Created by yossa on 16/12/2567 BE.
//

import Combine
import Foundation

// MARK: - BookingListViewModel

class BookingListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(
    fetchingService: PendingBookingListFetchingService,
    acceptBookingService: AcceptBookingService,
    rejectBookingService: RejectBookingService)
  {
    self.fetchingService = fetchingService
    self.acceptBookingService = acceptBookingService
    self.rejectBookingService = rejectBookingService
  }

  // MARK: Internal

  @Published private(set) var items: [PendingBookingItem] = []
  
  func onAppear() {
    Task { @MainActor in
      await fetchBookingList()
    }
  }

  @MainActor
  func acceptBooking(item: PendingBookingItem) async {
    do {
      let updatedItems = try await acceptBookingService.acceptBooking(item)
      items = updatedItems
    } catch {
      // Handle error
    }
  }

  @MainActor
  func rejectBooking(item: PendingBookingItem) async {
    do {
      let updatedItems = try await rejectBookingService.rejectBooking(item)
      items = updatedItems
    } catch {
      // Handle error
    }
  }

  // MARK: Private

  private let fetchingService: PendingBookingListFetchingService
  private let acceptBookingService: AcceptBookingService
  private let rejectBookingService: RejectBookingService

  private func fetchBookingList() async {
    do {
      let result = try await fetchingService.fetchPendingBookingList()
      items = result
    } catch {
      // Handle error
    }
  }
}

// MARK: - PendingBookingListFetchingService

protocol PendingBookingListFetchingService {
  func fetchPendingBookingList() async throws -> [PendingBookingItem]
}

// MARK: - AcceptBookingService

protocol AcceptBookingService {
  func acceptBooking(_ bookingItem: PendingBookingItem) async throws -> [PendingBookingItem]
}

// MARK: - RejectBookingService

protocol RejectBookingService {
  func rejectBooking(_ bookingItem: PendingBookingItem) async throws -> [PendingBookingItem]
}

// MARK: - PendingBookingItem

struct PendingBookingItem: Identifiable {
  let id: String
  let name: String
  let dateString: String
  let timeString: String
  let imageURL: URL
}
