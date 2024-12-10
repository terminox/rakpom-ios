//
//  Reservation.swift
//  Rakpom
//
//  Created by CatMeox on 23/5/2567 BE.
//

import SwiftUI


// MARK: - ShopDetailView

struct ShopDetailView: View {

  @ObservedObject var viewModel: ReservationViewModel

  var body: some View {
    if viewModel.isLoading {
      ProgressView()
        .progressViewStyle(.circular)
    } else if let detail = viewModel.detail {
      ReservationStatelessView(
        detail: detail,
        selectedDate: $selectedDate,
        startTime: $startTime)
    }
  }

  @State private var selectedDate = Date()
  @State private var startTime = Date()

}

// MARK: - ReservationStatelessView

struct ReservationStatelessView: View {

  let detail: ShopDetail

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
              // TODO
            } label: {
              HStack(alignment: .center, spacing: 4) {
                ForEach(0..<detail.rating) { _ in
                  Image(systemName: "star.fill")
                    .font(.callout)
                    .fontDesign(.rounded)
                    .foregroundColor(.yellow)
                }
                ForEach(0..<(5 - detail.rating)) { _ in
                  Image(systemName: "star.fill")
                    .font(.callout)
                    .fontDesign(.rounded)
                    .foregroundColor(.lightGray)
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

          NavigationLink(value: AnyHashable(ConfirmationLayoutItem(rowItems: [
            ConfirmationRowItem(title: "ชื่อร้าน", value: "ร้านลุงหนุ่ม"),
            ConfirmationRowItem(title: "ชื่อลูกค้า", value: "กวิน ยินดี"),
            ConfirmationRowItem(title: "วันที่", value: "19/08/67"),
            ConfirmationRowItem(title: "เวลาที่จอง", value: "9:30 - 10:30 น."),
          ]))) {
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

  BackScaffold {
    ReservationStatelessView(detail: detail, selectedDate: $selectedDate, startTime: $startTime)
  }
}
