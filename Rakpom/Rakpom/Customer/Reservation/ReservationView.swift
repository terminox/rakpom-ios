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

struct ReservationView: View {
  @State var selectedDate: Date = Date()
  @State var startTime: Date = Date()
  @State var endTime: Date = Date()
  
  let id: String
  
  let detail = BookingDetail(rating: 1, reviewCount: 4)
  
  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .leading, spacing: 0) {
        
        // HEADER
        BackHeaderView(title: "จองคิว", id: "qwerty")
        
        ScrollView(showsIndicators: false) {
          Image("Barber3")
            .resizable()
            .frame(width: geo.size.width, height: geo.size.height * 0.3)
          
          // SHOP DETAILS
          VStack(alignment: .leading, spacing: 8) {
            Text("ร้านลุงหนุ่ม")
              .font(.custom("Noto Sans Thai", size: 18))
              .fontWeight(.bold)
              .foregroundStyle(.black)
            
            NavigationLink(value: AnyHashable(BookingReviewsNavItem(bookingID: id))) {
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
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
              Image(systemName: "phone.fill")
                .font(.callout)
             
              Text("095-458769")
                .font(.custom("Noto Sans Thai", size: 16))
                .foregroundStyle(.black)
                .lineLimit(3)
                .padding(.horizontal, 4)
            }
            
            Text("เปิดร้าน 10:00 - 20:00 น.")
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundStyle(.black)
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
              Image("Location")
                .resizable()
                .frame(width: 11, height: 14)
             
              Text("35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
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
      }
    }
    .padding(.bottom, 20)
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  ReservationView(id: "asd")
}
