//
//  AlamofireNotificationListService.swift
//  Rakpom
//
//  Created by yossa on 29/11/2567 BE.
//

import Foundation

class AlamofireNotificationListService: NotificationListService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  let url: URL
  let client: RakpomAlamofireWrapper

  func fetchNotifications() async throws -> [NotificationItem] {
    let request = try await client.getRequest(from: url)
    let items: [RemoteNotificationItem] = try await client.perform(request)
    return items.map { $0.toLocal() }
  }

  // MARK: Private

  private struct RemoteNotificationItem: Decodable {
    let title: String
    let description: String
    let dateString: String

    func toLocal() -> NotificationItem {
      .init(
        title: title,
        description: description,
        dateString: dateString)
    }
  }
}
