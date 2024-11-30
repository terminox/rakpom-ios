//
//  AlamofireRootInitialStateAdapterUserProfileService.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import Foundation

// MARK: - AlamofireRootInitialStateAdapterUserProfileService

class AlamofireRootInitialStateAdapterUserProfileService: RootInitialStateAdapterUserProfileService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  let url: URL
  let client: RakpomAlamofireWrapper

  func verifyUserProfile() async throws {
    let request = try await client.getRequest(from: url)
    try await client.perform(request)
  }
}
