//
//  FeedbackView.swift
//  Rakpom
//
//  Created by CatMeox on 31/5/2567 BE.
//

import SwiftUI

// MARK: - FeedbackView

struct FeedbackView: View {

  @ObservedObject var viewModel: FeedbackViewModel

  @State private var reviewText = ""
  @State private var rating = 0

  var body: some View {
    FeedbackContentView(
      reviewText: $reviewText,
      rating: $rating,
      onConfirmed: {
        Task { @MainActor in
          let payload = FeedbackPayload(score: rating, content: reviewText)
          await viewModel.submit(payload: payload)
        }
      },
      onCanceled: viewModel.onCanceled)
  }
}

// MARK: - FeedbackContentView

struct FeedbackContentView: View {

  @Binding var reviewText: String
  @Binding var rating: Int

  let onConfirmed: () -> Void
  let onCanceled: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      Image(.review)

      Text("ให้คะแนนความพึงพอใจ")
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundStyle(.black)
        .fontWeight(.semibold)

      RatingView(rating: $rating)
        .padding()
        .padding(.bottom)

      VStack(alignment: .leading, spacing: 8) {
        Text("เขียนรีวิว")
          .font(.custom("Noto Sans Thai", size: 14))
          .foregroundStyle(.black)

        TextField("เขียนข้อความที่นี่...", text: $reviewText)
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)
          .padding()
          .frame(maxWidth: .infinity)
          .frame(height: 48)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .stroke(.gray))
          .padding(.bottom, 60)

        Button {
          onConfirmed()
        } label: {
          AppButton(title: "ยืนยัน")
        }
        .padding(.bottom, 8)

        Button {
          onCanceled()
        } label: {
          Text("ยกเลิก")
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.blueButton)
            .frame(maxWidth: .infinity)
            .frame(height: 47)
            .background(.white)
            .clipShape(Capsule())
            .overlay(
              RoundedRectangle(cornerRadius: 50)
                .stroke(Color("BlueButton")))
        }
      }
      .padding(.horizontal, 32)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.white)
  }
}

#Preview {
  @Previewable @State var reviewText = ""
  @Previewable @State var rating = 0

  FeedbackContentView(reviewText: $reviewText, rating: $rating, onConfirmed: {}, onCanceled: {})
}
