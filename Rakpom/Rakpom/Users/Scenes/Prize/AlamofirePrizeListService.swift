//
//  AlamofirePrizeListService.swift
//  Rakpom
//
//  Created by yossa on 27/11/2567 BE.
//

import Foundation

class AlamofirePrizeListService: PrizeListService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  struct RemotePrizeItem: Decodable {
    let title: String
    let value: String

    func toLocal() -> PrizeItem {
      .init(title: title, value: value)
    }
  }

  let url: URL
  let client: RakpomAlamofireWrapper

  func fetchPrizeItems() async throws -> [PrizeItem] {
    let request = try await client.getRequest(from: url)
    let items: [RemotePrizeItem] = try await client.perform(request)
    return items.map { $0.toLocal() }
  }
}
