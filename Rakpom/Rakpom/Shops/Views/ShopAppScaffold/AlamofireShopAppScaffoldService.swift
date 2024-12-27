//
//  AlamofireShopAppScaffoldService.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import Alamofire
import Foundation

class AlamofireShopAppScaffoldService: ShopAppScaffoldService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  struct RemoteShop: Decodable {
    let id: String
    let fullName: String
    let avatarURL: URL
    let shopCode: String

    func toLocal() -> AppScaffoldShop {
      .init(name: fullName, avatarURL: avatarURL, shopCode: shopCode)
    }
  }

  let url: URL
  let client: RakpomAlamofireWrapper
  
  func fetchShop() async throws -> AppScaffoldShop {
    let request = try await client.getRequest(from: url)
    let remoteShop: RemoteShop = try await client.perform(request)
    return remoteShop.toLocal()
  }
}
