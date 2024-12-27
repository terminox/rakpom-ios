//
//  ReservationViewModel.swift
//  Rakpom
//
//  Created by yossa on 31/8/2567 BE.
//

import Foundation

// MARK: - ShopDetailViewModel

class ShopDetailViewModel: ObservableObject {

  // MARK: Lifecycle

  init(
    shopDetailService: any ShopDetailService,
    bookingRequestCreatingService: any BookingRequestCreatingService,
    onReviewsPressed: @escaping () -> Void,
    onConfirmed: @escaping ([BookingConfirmationDetailItem]) -> Void)
  {
    self.shopDetailService = shopDetailService
    self.bookingRequestCreatingService = bookingRequestCreatingService
    self.onReviewsPressed = onReviewsPressed
    self.onConfirmed = onConfirmed
  }

  // MARK: Internal

  @Published var detail: ShopDetail?
  @Published var isLoading = false
  @Published var isConfirming = false
  @Published var error: Error?

  func onAppear() {
    Task { @MainActor in
      await fetchShopDetail()
    }
  }

  func didPressReviews() {
    onReviewsPressed()
  }

  @MainActor
  func fetchShopDetail() async {
    isLoading = true
    error = nil

    do {
      detail = try await shopDetailService.fetchShopDetail()
    } catch {
      self.error = error
    }

    isLoading = false
  }

  @MainActor
  func confirm(date: Date, startTime: Date) async {
    isConfirming = true

    defer {
      isConfirming = false
    }

    let calendar = Calendar.current
    let startHour = calendar.component(.hour, from: startTime)
    let startMinute = calendar.component(.minute, from: startTime)
    let payload = ShopDetailBookingPayload(
      millisSince1970: date.timeIntervalSince1970,
      startHour: startHour,
      startMinute: startMinute)

    if let items = try? await bookingRequestCreatingService.createBookingRequest(payload: payload) {
      onConfirmed(items)
    }
  }

  // MARK: Private

  private let shopDetailService: any ShopDetailService
  private let bookingRequestCreatingService: any BookingRequestCreatingService
  private let onReviewsPressed: () -> Void
  private let onConfirmed: ([BookingConfirmationDetailItem]) -> Void

}

// MARK: - ShopDetailService

protocol ShopDetailService {
  func fetchShopDetail() async throws -> ShopDetail
}

// MARK: - BookingRequestCreatingService

protocol BookingRequestCreatingService {
  func createBookingRequest(payload: ShopDetailBookingPayload) async throws -> [BookingConfirmationDetailItem]
}

// MARK: - ShopDetailBookingPayload

struct ShopDetailBookingPayload {
  let millisSince1970: Double
  let startHour: Int
  let startMinute: Int
}

// MARK: - ShopDetail

struct ShopDetail {
  let name: String
  let coverImageURL: URL
  let rating: Int
  let reviewCount: Int
  let tel: String
  let businessHours: String
  let address: String
}
