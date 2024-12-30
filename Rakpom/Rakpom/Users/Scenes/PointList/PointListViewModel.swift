//
//  PointListViewModel.swift
//  Rakpom
//
//  Created by yossa on 30/12/2567 BE.
//

import Combine
import Foundation

// MARK: - PointListViewModel

class PointListViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: PointListService) {
    self.service = service
  }

  // MARK: Internal

  @Published private(set) var isLoading = false
  @Published private(set) var error: String?
  @Published private(set) var userProfile: PointsUserProfile?
  
  @MainActor
  func onAppear() async {
    await fetchUserProfile()
  }

  func refreshUserProfile() {
    Task { @MainActor in
      await fetchUserProfile()
    }
  }

  // MARK: Private

  private let service: PointListService

  @MainActor
  private func fetchUserProfile() async {
    isLoading = true
    error = nil

    do {
      userProfile = try await service.fetchPointsUserProfile()
      error = nil
    } catch {
      self.error = error.localizedDescription
      userProfile = nil
    }

    isLoading = false
  }
}

// MARK: - PointsUserProfile

struct PointsUserProfile {
  let avatarURL: URL
  let fullName: String
  let memberID: String
  let totalPoints: Int
  let points: [ProfilePoint]
}

// MARK: - ProfilePoint

struct ProfilePoint: Identifiable {
  let id: String
  let point: Int
  let dateString: String
}

// MARK: - PointListService

protocol PointListService {
  func fetchPointsUserProfile() async throws -> PointsUserProfile
}
