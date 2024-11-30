//
//  NotificationListView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

// MARK: - NotificationListView

struct NotificationListView: View {

  @ObservedObject var viewModel: NotificationListViewModel


  var body: some View {
    let items = viewModel.items

    GeometryReader { _ in
      VStack(spacing: 0) {
        TitleView(title: "แจ้งเตือน", color: .white)

        ScrollView {
          VStack(spacing: 0) {
            ForEach(items) { item in
              NotificationListItemView(item: item)
            }
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
    .task {
      await viewModel.fetchNotifications()
    }
  }
}

// MARK: - NotificationListItemView

struct NotificationListItemView: View {

  let item: NotificationItem

  var body: some View {
    HStack(spacing: 16) {
      Image(.uppercut)
        .resizable()
        .frame(width: 63, height: 63)
        .padding()
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 4))

      VStack(alignment: .leading, spacing: 6) {
        HStack {
          Text(item.title)
            .font(.custom("Noto Sans Thai", size: 14))
            .fontWeight(.medium)
            .foregroundStyle(.black)

          Spacer()

          Text(item.dateString)
            .font(.custom("Noto Sans Thai", size: 12))
            .foregroundStyle(.halfGray)
        }

        Text(item.description)
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
