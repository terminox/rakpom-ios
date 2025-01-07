//
//  FeedbackViewModel.swift
//  Rakpom
//
//  Created by yossa on 15/12/2567 BE.
//

import Foundation

// MARK: - FeedbackViewModel

class FeedbackViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: FeedbackService, onCompleted: @escaping () -> Void, onCanceled: @escaping () -> Void) {
    self.service = service
    self.onCompleted = onCompleted
    self.onCanceled = onCanceled
  }

  // MARK: Internal

  @Published var isLoading = false
  
  let onCompleted: () -> Void
  let onCanceled: () -> Void

  @MainActor
  func submit(payload: FeedbackPayload) async {
    isLoading = true

    defer {
      isLoading = false
    }
    
    try? await service.submitFeedback(payload: payload)
    onCompleted()
  }

  // MARK: Private

  private let service: FeedbackService
}

// MARK: - FeedbackService

protocol FeedbackService {
  func submitFeedback(payload: FeedbackPayload) async throws -> Void
}

// MARK: - FeedbackPayload

struct FeedbackPayload {
  let score: Int
  let content: String
}
