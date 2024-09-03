//
//  NotificationViewModel.swift
//  Rakpom
//
//  Created by CatMeox on 3/9/2567 BE.
//

import SwiftUI

struct NotificationResponse: Decodable {
  let data: [Notification]?
  let error: String?
}

struct Notification: Decodable, Identifiable {
  let id: String
  let title: String
  let description: String
  let dateString: String
  let imageURL: URL
}

class NotificationViewModel: ObservableObject {
  
  @Published var notifications: [NotificationItem] = []
  
  @MainActor
  func fetchNotification() async {
    let session = URLSession(configuration: .ephemeral)
    let url = URL(string: "https://f166-184-22-191-39.ngrok-free.app/api/v1/users/notifications/pages?offset=0&limit=20")!
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMDFKNE1EWjdUMTgwSFQ1OTZGOFI1RTJQMU4iLCJlbWFpbCI6InRlc3QxQHJha3BvbS5kZXYiLCJtZW1iZXJJRCI6IjEiLCJmdWxsTmFtZSI6bnVsbCwiZ2VuZGVyIjpudWxsLCJwaG9uZU51bWJlciI6bnVsbH0sImlhdCI6MTcyMjk2Nzg1M30.jwFbYPpfDlATDBSe4A7guaNkTVMzWnicGqmLud2Bc0o", forHTTPHeaderField: "Authorization")
    
    do {
      let (data, _) = try await session.data(for: urlRequest)
      print("data: ", data)
      let decoder = JSONDecoder()
      let response = try decoder.decode(NotificationResponse.self, from: data)
      
      if let errorMessage = response.error {
        print(errorMessage)
        return
      }
      
      if let notification = response.data {
        var notifications: [NotificationItem] = []
        
        for notification in notification {
          let image = AnyView(
            AsyncImage(
              url: notification.imageURL,
              content: { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              },
              placeholder: {
                EmptyView()
              }
            )
          )
          
          notifications.append(NotificationItem(
            id: notification.id,
            title: notification.title,
            description: notification.description,
            dateString: notification.dateString,
            image: image
          ))
        }
        
        self.notifications = notifications
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
