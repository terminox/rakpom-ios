//
//  NotificationListViewModel.swift
//  Rakpom
//
//  Created by yossa on 29/11/2567 BE.
//

import Foundation

// MARK: - NotificationListViewModel

class NotificationListViewModel: ObservableObject {

  @Published var items: [NotificationItem] = []
  @Published var isLoading = false
  @Published var error: Error?
  
  private let service: NotificationListService
  
  init(service: NotificationListService) {
    self.service = service
  }
  
  @MainActor
  func fetchNotifications() async {
    isLoading = true
    error = nil
    
    do {
      items = try await service.fetchNotifications()
    } catch {
      self.error = error
    }
    
    isLoading = false
  }
}

// MARK: - NotificationListService

protocol NotificationListService {
  func fetchNotifications() async throws -> [NotificationItem]
}

// MARK: - NotificationItem

struct NotificationItem: Identifiable {
  let id = UUID()
  let title: String
  let description: String
  let dateString: String
}
