//
//  AlamofireUserAppScaffoldService.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import Alamofire
import Foundation

class AlamofireUserAppScaffoldService: UserAppScaffoldService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  struct RemoteUser: Decodable {
    let id: String
    let fullName: String
    let avatarURL: URL
    let totalPoints: Int

    func toLocal() -> AppScaffoldUser {
      .init(name: fullName, avatarURL: avatarURL, points: totalPoints)
    }
  }

  let url: URL
  let client: RakpomAlamofireWrapper

  func fetchUser() async throws -> AppScaffoldUser {
    let request = try await client.getRequest(from: url)
    let remoteUser: RemoteUser = try await client.perform(request)
    return remoteUser.toLocal()
  }
}
