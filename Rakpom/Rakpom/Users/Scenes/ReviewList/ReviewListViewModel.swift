//
//  ReviewListViewModel.swift
//  Rakpom
//
//  Created by yossa on 24/12/2567 BE.
//

import Foundation

// MARK: - ReviewListViewModel

class ReviewListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: ShopReviewListFetchingService) {
    self.service = service
  }

  // MARK: Internal

  @Published private(set) var reviews: [ShopReviewItem] = []

  func onAppear() {
    Task { @MainActor in
      await fetchReviews()
    }
  }

  // MARK: Private

  private let service: ShopReviewListFetchingService

  @MainActor
  private func fetchReviews() async {
    reviews = (try? await service.fetchShopReviewList()) ?? []
  }
}

// MARK: - ShopReviewListFetchingService

protocol ShopReviewListFetchingService {
  func fetchShopReviewList() async throws -> [ShopReviewItem]
}

// MARK: - ShopReviewItem

struct ShopReviewItem: Identifiable {
  let id: String
  let reviewerName: String
  let score: Int
  let text: String
  let dateString: String
  let reviewerImageURL: URL
}
