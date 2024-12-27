//
//  UserAppScaffoldViewModel.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import Foundation

// MARK: - UserAppScaffoldViewModel

class UserAppScaffoldViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any UserAppScaffoldService) {
    self.service = service
  }

  // MARK: Internal

  let service: any UserAppScaffoldService

  @Published var user: AppScaffoldUser?

  @MainActor
  func fetch() async {
    user = try? await service.fetchUser()
  }
}

// MARK: - UserAppScaffoldService

protocol UserAppScaffoldService {
  func fetchUser() async throws -> AppScaffoldUser
}

// MARK: - AppScaffoldUser

struct AppScaffoldUser {
  let name: String
  let avatarURL: URL
  let points: Int
}
