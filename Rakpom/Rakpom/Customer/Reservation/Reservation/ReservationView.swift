//
//  Reservation.swift
//  Rakpom
//
//  Created by CatMeox on 23/5/2567 BE.
//

import SwiftUI

struct BookingDetail {
  let rating: Int
  let reviewCount: Int
}

struct BookingReviewsNavItem: Hashable {
  let bookingID: String
}

struct ShopDetail {
    let id: String
    let name: String
    let ownerName: String
    let phone: String
    let image: AnyView
    let rating: Int
    let reviewCount: Int
    let address: String
    let businessHours: String
}

struct ReservationView: View {
  @State var selectedDate: Date = Date()
  @State var startTime: Date = Date()
  @State var endTime: Date = Date()
  
  @StateObject var viewModel = ReservationViewModel ()
  
  let id: String
  
  let detail = BookingDetail(rating: 1, reviewCount: 4)
  
  
  
  var body: some View {
    
//    let shopDetails = viewModel.shopDetails
    
    GeometryReader { geo in
      VStack(alignment: .leading, spacing: 0) {
        
        // HEADER
        BackHeaderView(title: "จองคิว", id: "qwerty")
        
        if let shopDetail = viewModel.shopDetail {
          ScrollView(showsIndicators: false) {
            shopDetail.image
  //            .resizable()
              .frame(width: geo.size.width, height: geo.size.height * 0.3)
            
            // SHOP DETAILS
            VStack(alignment: .leading, spacing: 8) {
              Text(shopDetail.name)
                .font(.custom("Noto Sans Thai", size: 18))
                .fontWeight(.bold)
                .foregroundStyle(.black)
              
              NavigationLink(value: AnyHashable(BookingReviewsNavItem(bookingID: id))) {
                HStack(alignment: .center, spacing: 4) {
                  ForEach(0..<shopDetail.rating) { _ in
                    Image(systemName: "star.fill")
                      .font(.callout)
                      .fontDesign(.rounded)
                      .foregroundColor(.yellow)
                  }
                  ForEach(0..<(5 - shopDetail.rating)) { _ in
                    Image(systemName: "star.fill")
                      .font(.callout)
                      .fontDesign(.rounded)
                      .foregroundColor(.lightGray)
                  }
                  
                  Text("(\(shopDetail.reviewCount))")
                    .font(.custom("Noto Sans Thai", size: 16))
                    .foregroundStyle(.gray)
                }
              }
              
              HStack(alignment: .firstTextBaseline, spacing: 0) {
                Image(systemName: "phone.fill")
                  .font(.callout)
               
                Text(shopDetail.phone)
                  .font(.custom("Noto Sans Thai", size: 16))
                  .foregroundStyle(.black)
                  .lineLimit(3)
                  .padding(.horizontal, 4)
              }
              
              Text("เปิดร้าน " + shopDetail.businessHours)
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundStyle(.black)
              
              HStack(alignment: .firstTextBaseline, spacing: 0) {
                Image("Location")
                  .resizable()
                  .frame(width: 11, height: 14)
               
                Text(shopDetail.address)
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
                  
                  DatePicker("",
                             selection: $selectedDate,
                             in: Date()...,
                             displayedComponents: [.date]
                  )
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
                    .padding(.leading)
                  
                  Text("เวลา")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 8)
                    .background(.white)
                    .position(x:55, y: 15)
                  
                  HStack {
                    Image(systemName: "clock")
                      .foregroundStyle(.darkGray)
                    
                    DatePicker("",
                               selection: $startTime,
                               in: Date()...,
                               displayedComponents: [.hourAndMinute]
                    )
                    .font(.caption2)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    
                    Spacer()
                  }
                  .padding(.leading, 40)
                }
                .frame(height: 80)
                
                ZStack {
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray.opacity(0.5), lineWidth: 1.5)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .padding(.trailing)
                  
                  Text("ถึง")
                    .font(.custom("Noto Sans Thai", size: 12))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 8)
                    .background(.white)
                    .position(x:30, y: 15)
                  
                  HStack {
                    Image(systemName: "clock")
                      .foregroundStyle(.darkGray)
                    
                    DatePicker("",
                               selection: $endTime,
                               in: Date()...,
                               displayedComponents: [.hourAndMinute]
                    )
                    .foregroundStyle(.black)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    
                    Spacer()
                  }
                  .padding(.leading, 20)
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
        } else {
          VStack {
            ProgressView() {
              Text("")
              Text("กำลังดาวน์โหลดข้อมูลร้านค้า")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.black)
            }
            .tint(.blueButton)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }
    }
    .padding(.bottom, 20)
    .background(.white)
    .ignoresSafeArea()
    .task {
      await viewModel.fetchShopDetail()
    }
  }
}

#Preview {
  ReservationView(id: "asd")
}
