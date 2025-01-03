//
//  ReviewListView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

// MARK: - ReviewListView

struct ReviewListView: View {

  @ObservedObject var viewModel: ReviewListViewModel

  var body: some View {
    ReviewListContentView(items: viewModel.reviews)
      .onAppear(perform: viewModel.onAppear)
  }
}

// MARK: - ReviewListContentView

struct ReviewListContentView: View {

  let items: [ShopReviewItem]

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        ForEach(items) { item in
          ReviewListItemView(item: item)
          
          Divider()
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

// MARK: - ReviewListItemView

struct ReviewListItemView: View {
  
  let item: ShopReviewItem
 
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        HStack {
          AsyncImage(url: item.reviewerImageURL) { image in
            image
              .resizable()
              .frame(width: 30, height: 30)
              .clipShape(Circle())
          } placeholder: {
            Circle()
              .frame(width: 30, height: 30)
              .foregroundStyle(.gray)
          }

          Text(item.reviewerName)
            .font(.custom("Noto Sans Thai", size: 18))
            .fontWeight(.medium)
            .foregroundStyle(.black)
        }

        Spacer()

        Text(item.dateString)
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.gray)
      }

      HStack(spacing: 4) {
        ForEach(0..<5) { i in
          Image(systemName: "star.fill")
            .font(.callout)
            .foregroundColor(i < item.score ? .yellow : .lightGray)
        }
      }
      .padding(.leading, 40)

      Text(item.text)
        .font(.custom("Noto Sans Thai", size: 14))
        .foregroundStyle(.black)
        .padding(.top, 8)
    }
    .padding()
  }
}

#Preview {
  let items: [ShopReviewItem] = [
    ShopReviewItem(
      id: UUID().uuidString,
      reviewerName: "John Doe",
      score: 5,
      text: "Great service!",
      dateString: "2021-01-01",
      reviewerImageURL: URL(string: "https://example.com/avatar.jpg")!),
    ShopReviewItem(
      id: UUID().uuidString,
      reviewerName: "Jane Doe",
      score: 4,
      text: "Good service!",
      dateString: "2021-01-02",
      reviewerImageURL: URL(string: "https://example.com/avatar.jpg")!),
    ShopReviewItem(
      id: UUID().uuidString,
      reviewerName: "Jane Doe",
      score: 0,
      text: "Good service!",
      dateString: "2021-01-03",
      reviewerImageURL: URL(string: "https://example.com/avatar.jpg")!),
    ShopReviewItem(
      id: UUID().uuidString,
      reviewerName: "Jane Doe",
      score: 3,
      text: "Good service!",
      dateString: "2021-01-04",
      reviewerImageURL: URL(string: "https://example.com/avatar.jpg")!),
    ShopReviewItem(
      id: UUID().uuidString,
      reviewerName: "Jane Doe",
      score: 1,
      text: "Good service!",
      dateString: "2021-01-05",
      reviewerImageURL: URL(string: "https://example.com/avatar.jpg")!),
  ]

  ReviewListContentView(items: items)
}
