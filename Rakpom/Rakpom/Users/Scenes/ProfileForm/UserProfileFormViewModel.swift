//
//  UserProfileFormViewModel.swift
//  Rakpom
//
//  Created by yossa on 4/1/2568 BE.
//

import Foundation

// MARK: - UserProfileFormViewModel

class UserProfileFormViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: UserProfileUpdatingService, onComplete: @escaping () -> Void) {
    self.service = service
    self.onComplete = onComplete
  }

  // MARK: Internal

  @Published private(set) var isLoading = false

  @MainActor
  func submit(payload: UserSignupPayload) async {
    isLoading = true
    
    defer {
      isLoading = false
    }
    
    do {
      try await service.updateProfile(payload: payload)
      onComplete()
    } catch {
      print(error.localizedDescription)
    }
  }

  // MARK: Private

  private let service: UserProfileUpdatingService
  private let onComplete: () -> Void

}

// MARK: - UserProfileUpdatingService

protocol UserProfileUpdatingService {
  func updateProfile(payload: UserSignupPayload) async throws -> Void
}

// MARK: - UserSignupPayload

struct UserSignupPayload {
  let imageData: Data
  let fullName: String
  let gender: Gender
  let age: String
  let phone: String
  let email: String?
}

// MARK: - Gender

enum Gender {
  case male
  case female
}
