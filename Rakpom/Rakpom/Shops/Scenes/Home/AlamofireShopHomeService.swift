//
//  AlamofireShopHomeService.swift
//  Rakpom
//
//  Created by yossa on 14/1/2568 BE.
//

import Alamofire
import Foundation

class AlamofireShopHomeService: ShopHomeService {

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
    let phone: String
    let address: String

    func toLocal() -> ShopHomeDetailItem {
      .init(coverImageURL: avatarURL, telNo: phone, address: address)
    }
  }

  let url: URL
  let client: RakpomAlamofireWrapper


  func fetchShopHomeItem() async throws -> ShopHomeDetailItem {
    let request = try await client.getRequest(from: url)
    let remoteShop: RemoteShop = try await client.perform(request)
    return remoteShop.toLocal()
  }
}
