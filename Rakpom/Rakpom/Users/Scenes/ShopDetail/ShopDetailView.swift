//
//  ShopDetailView.swift
//  Rakpom
//
//  Created by CatMeox on 23/5/2567 BE.
//

import SwiftUI


// MARK: - ShopDetailView

struct ShopDetailView: View {

  // MARK: Internal

  @ObservedObject var viewModel: ShopDetailViewModel

  var body: some View {
    VStack {
      if viewModel.isLoading {
        Spacer()

        ProgressView()
          .progressViewStyle(.circular)

        Spacer()
      } else if let detail = viewModel.detail {
        ShopDetailContentView(
          detail: detail,
          onReviewsPressed: viewModel.didPressReviews,
          onConfirmPressed: didPressConfirm,
          selectedDate: $selectedDate,
          startTime: $startTime)
      }
    }
    .onAppear(perform: viewModel.onAppear)
  }

  // MARK: Private

  @State private var selectedDate = Date()
  @State private var startTime = Date()
  
  private func didPressConfirm() {
    Task { @MainActor in
      await viewModel.confirm(date: selectedDate, startTime: startTime)
    }
  }

}

// MARK: - ShopDetailContentView

struct ShopDetailContentView: View {

  let detail: ShopDetail
  let onReviewsPressed: () -> Void
  let onConfirmPressed: () -> Void

  @Binding var selectedDate: Date
  @Binding var startTime: Date

  var body: some View {
    GeometryReader { geo in
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: 0) {
          // Cover Image
          AsyncImage(
            url: detail.coverImageURL,
            content: { image in
              image
                .resizable()
                .frame(width: geo.size.width, height: geo.size.height * 0.3)
            },
            placeholder: {
              Rectangle()
                .foregroundStyle(.halfGray)
                .frame(width: geo.size.width, height: geo.size.height * 0.3)
            })
            .frame(width: geo.size.width, height: geo.size.height * 0.3)

          // SHOP DETAILS
          VStack(alignment: .leading, spacing: 8) {
            Text(detail.name)
              .font(.custom("Noto Sans Thai", size: 18))
              .fontWeight(.bold)
              .foregroundStyle(.black)

            Button {
              onReviewsPressed()
            } label: {
              HStack(alignment: .center, spacing: 4) {
                ForEach(0..<5) { i in
                  Image(systemName: "star.fill")
                    .font(.callout)
                    .fontDesign(.rounded)
                    .foregroundColor(i < detail.rating ? .yellow : .lightGray)
                }

                Text("(\(detail.reviewCount))")
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundStyle(.gray)
              }
            }

            // Tel
            HStack(alignment: .firstTextBaseline, spacing: 0) {
              Image(systemName: "phone.fill")
                .font(.callout)

              Text(detail.tel)
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundStyle(.black)
                .lineLimit(3)
                .padding(.horizontal, 4)
            }

            // Business Hours
            Text(detail.businessHours)
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundStyle(.black)

            // Address
            HStack(alignment: .firstTextBaseline, spacing: 0) {
              Image(.location)
                .resizable()
                .frame(width: 11, height: 14)

              Text(detail.address)
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.gray)
                .lineLimit(3)
                .padding(.horizontal, 4)
            }
          }
          .padding()
          .frame(width: geo.size.width, alignment: .leading)

          // RESERVATION
          Text("จองคิวตัดผม")
            .font(.custom("Noto Sans Thai", size: 16))
            .fontWeight(.medium)
            .foregroundStyle(.black)
            .padding()
            .frame(width: geo.size.width, height: 39, alignment: .leading)
            .background(.blueApp)

          VStack(spacing: 0) {
            ZStack {
              RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.5), lineWidth: 1.5)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .padding()

              Text("วัน")
                .font(.custom("Noto Sans Thai", size: 12))
                .foregroundStyle(.black)
                .padding(.horizontal, 8)
                .background(.white)
                .position(x:50, y: 15)

              HStack {
                Image(systemName: "calendar")
                  .foregroundStyle(.darkGray)

                DatePicker(
                  "",
                  selection: $selectedDate,
                  in: Date()...,
                  displayedComponents: [.date])
                  .labelsHidden()
                  .datePickerStyle(.compact)
                  .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)

                Spacer()
              }
              .padding(.leading, 40)
            }
            .frame(height: 80)

            HStack(spacing: 8) {
              ZStack {
                RoundedRectangle(cornerRadius: 12)
                  .stroke(.gray.opacity(0.5), lineWidth: 1.5)
                  .frame(maxWidth: .infinity)
                  .frame(height: 48)
                  .padding(.horizontal)

                Text("เวลา")
                  .font(.custom("Noto Sans Thai", size: 12))
                  .foregroundStyle(.black)
                  .padding(.horizontal, 8)
                  .background(.white)
                  .position(x:55, y: 15)

                HStack {
                  Image(systemName: "clock")
                    .foregroundStyle(.darkGray)

                  DatePicker(
                    "",
                    selection: $startTime,
                    in: Date()...,
                    displayedComponents: [.hourAndMinute])
                    .font(.caption2)
                    .labelsHidden()
                    .datePickerStyle(.compact)

                  Spacer()
                }
                .padding(.horizontal, 40)
              }
              .frame(height: 80)
            }
          }

          Button {
            onConfirmPressed()
          } label: {
            AppButton(title: "ยืนยัน")
          }
          .padding(.horizontal, 36)
        }
      }
    }
    .padding(.bottom, 20)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  @Previewable @State var selectedDate = Date()
  @Previewable @State var startTime = Date()

  let detail = ShopDetail(
    name: "ร้านลุงหนุ่ม",
    coverImageURL: URL(string: "http://example.com")!,
    rating: 4,
    reviewCount: 2,
    tel: "095-458769",
    businessHours: "เปิดร้าน 10:00 - 20:00 น.",
    address: "35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")

  BackScaffold(title: "จองคิว") {
    ShopDetailContentView(
      detail: detail,
      onReviewsPressed: {},
      onConfirmPressed: {},
      selectedDate: $selectedDate,
      startTime: $startTime)
  }
}
