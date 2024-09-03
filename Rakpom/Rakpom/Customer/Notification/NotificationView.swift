//
//  NotificationView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

struct NotificationItem: Identifiable {
  let id: String
  let title: String
  let description: String
  let dateString: String
  let image: AnyView
}

struct NotificationView: View {
  
  @StateObject var viewModel = NotificationViewModel()
  
  var body: some View {
    let notifications = viewModel.notifications
    
    GeometryReader { geo in
      VStack(spacing: 0) {
        // HEADER
        CustomerHeaderView(id: "qwerty")
        
        TitleView(title: "แจ้งเตือน", color: .white)
        
        ScrollView {
          VStack(spacing: 0) {
            
            ForEach(notifications) { noti in
              NotificationItemView(notification: noti)
            }
          }
        }
      }
    }
    
    .background(.lightGray)
    .ignoresSafeArea()
    .task {
      await viewModel.fetchNotification()
    }
  }
}

#Preview {
  NotificationView()
}

struct NotificationItemView: View {
  
  let notification: NotificationItem
  
  var body: some View {
    HStack(spacing: 16) {
      notification.image
      //        .resizable()
        .frame(width: 63, height: 63)
        .padding()
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 4))
      
      VStack(alignment: .leading, spacing: 6) {
        HStack {
          Text(notification.title)
            .font(.custom("Noto Sans Thai", size: 14))
            .fontWeight(.medium)
            .foregroundStyle(.black)
          
          Spacer()
          
          Text(notification.dateString)
            .font(.custom("Noto Sans Thai", size: 12))
            .foregroundStyle(.halfGray)
        }
        
        Text(
"""
\(notification.description)
""")
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.darkGray)
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .frame(height: 110)
    .background(.white)
    .padding(.top, 5)
    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
  }
}
