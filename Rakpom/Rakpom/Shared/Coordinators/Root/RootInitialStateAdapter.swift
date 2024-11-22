//
//  RootInitialStateAdapter.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import Foundation

// MARK: - RootInitialStateAdapter

class RootInitialStateAdapter {

  // MARK: Lifecycle

  init(
    userDefaults: UserDefaults = .standard,
    userProfileService: any RootInitialStateAdapterUserProfileService,
    shopProfileService: any RootInitialStateAdapterShopProfileService)
  {
    self.userDefaults = userDefaults
    self.userProfileService = userProfileService
    self.shopProfileService = shopProfileService
  }

  // MARK: Internal

  let userDefaults: UserDefaults
  let userProfileService: any RootInitialStateAdapterUserProfileService
  let shopProfileService: any RootInitialStateAdapterShopProfileService

  var viewModel: RootViewModel?

  @MainActor
  func fetchInitialState() async {
    guard let registrationType = userDefaults.string(forKey: "registrationType") else {
      viewModel?.displaySignup()
      return
    }

    switch registrationType {
    case "USER":
      do {
        try await userProfileService.verifyUserProfile()
        viewModel?.displayMain()
      } catch {
        viewModel?.displaySignup()
      }

    case "SHOP":
      do {
        try await shopProfileService.verifyShopProfile()
        viewModel?.displayShopMain()
      } catch {
        viewModel?.displaySignup()
      }

    default:
      viewModel?.displaySignup()
      return
    }
  }
}

// MARK: - RootInitialStateAdapterUserProfileService

protocol RootInitialStateAdapterUserProfileService {
  func verifyUserProfile() async throws
}

// MARK: - RootInitialStateAdapterShopProfileService

protocol RootInitialStateAdapterShopProfileService {
  func verifyShopProfile() async throws
}
