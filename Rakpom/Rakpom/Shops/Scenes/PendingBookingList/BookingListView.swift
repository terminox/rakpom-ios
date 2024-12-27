//
//  ReservationView.swift
//  Rakpom
//
//  Created by CatMeox on 20/6/2567 BE.
//

import SwiftUI

struct BookingListView: View {
  
  @ObservedObject var viewModel: BookingListViewModel
  
  var body: some View {
    BookingListContentView(
      items: viewModel.items,
      onAcceptPressed: { item in
        Task { @MainActor in
          await viewModel.acceptBooking(item: item)
        }
      },
      onReceptPressed: { item in
        Task { @MainActor in
          await viewModel.rejectBooking(item: item)
        }
      })
      .onAppear(perform: viewModel.onAppear)
  }
}

struct BookingListContentView: View {
  
//  @State var autoReserve = true
  
  let items: [PendingBookingItem]
  let onAcceptPressed: (PendingBookingItem) -> Void
  let onReceptPressed: (PendingBookingItem) -> Void
  
  var body: some View {
    VStack(spacing: 0) {
//      Toggle("รับจองคิวอัตโนมัติ", isOn: $autoReserve)
//        .font(.custom("Noto Sans Thai", size: 18))
//        .foregroundStyle(.black)
//        .toggleStyle(SwitchToggleStyle(tint: .blueButton))
//        .padding()
//        .background(.white)
      
      ScrollView {
        VStack(spacing: 4) {
          ForEach(items) { item in
            BookingListItemView(item: item, onAcceptPressed: onAcceptPressed, onReceptPressed: onReceptPressed)
              .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
  }
}

struct BookingListItemView: View {
  
  let item: PendingBookingItem
  let onAcceptPressed: (PendingBookingItem) -> Void
  let onReceptPressed: (PendingBookingItem) -> Void
  
  var body: some View {
    HStack {
      AsyncImage(
        url: item.imageURL,
        content: { image in
          image
            .resizable()
            .frame(width: 74, height: 74)
            .clipShape(Circle())
            .overlay(
              Circle()
                .stroke(.halfGray)
            )
        },
        placeholder: {
          Circle()
            .foregroundStyle(.halfGray)
            .frame(width: 74, height: 74)
        })
        .padding()
        .padding(.top, -40)
      
      VStack(alignment: .leading) {
        Text(item.name)
          .fontWeight(.bold)
        
        HStack(spacing: 27) {
          Text(item.dateString)
            .padding(.leading, -9)
        }
        
        HStack(spacing: 18) {
          Text(item.timeString)
        }
        
        HStack {
          Button {
            onReceptPressed(item)
          } label: {
            Text("ไม่รับจอง")
              .font(.custom("Noto Sans Thai", size: 12))
              .frame(width: 86, height: 32)
              .foregroundStyle(.white)
              .background(.black)
              .clipShape(Capsule())
          }
          
          Button {
            onAcceptPressed(item)
          } label: {
            Text("รับจอง")
              .font(.custom("Noto Sans Thai", size: 12))
              .frame(width: 86, height: 32)
              .foregroundStyle(.white)
              .background(.blueButton)
              .clipShape(Capsule())
          }
        }
      }
      .font(.custom("Noto Sans Thai", size: 14))
      .foregroundStyle(.black)
      
      Spacer()
    }
    .padding(.leading, 25)
    .frame(maxWidth: .infinity)
    .padding(.vertical, 24)
    .background(.white)
  }
}

#Preview {
  let items: [PendingBookingItem] = [
    PendingBookingItem(
      id: "1",
      name: "กวิน ยินดี", 
      dateString: "12/09/2556",
      timeString: "12:00น. - 13:00น.",
      imageURL: URL(string: "https://unsplash.com/photos/grayscale-photo")!
    ),
    PendingBookingItem(
      id: "2",
      name: "กวิน ยินดี",
      dateString: "12/09/2556", 
      timeString: "12:00น. - 13:00น.",
      imageURL: URL(string: "https://unsplash.com/photos/grayscale-photo")!
    ),
    PendingBookingItem(
      id: "3",
      name: "กวิน ยินดี",
      dateString: "12/09/2556",
      timeString: "12:00น. - 13:00น.", 
      imageURL: URL(string: "https://unsplash.com/photos/grayscale-photo")!
    ),
    PendingBookingItem(
      id: "4", 
      name: "กวิน ยินดี",
      dateString: "12/09/2556",
      timeString: "12:00น. - 13:00น.",
      imageURL: URL(string: "https://unsplash.com/photos/grayscale-photo")!
    ),
    PendingBookingItem(
      id: "5",
      name: "กวิน ยินดี",
      dateString: "12/09/2556",
      timeString: "12:00น. - 13:00น.",
      imageURL: URL(string: "https://unsplash.com/photos/grayscale-photo")!
    )
  ]
  
  BookingListContentView(items: items, onAcceptPressed: { _ in }, onReceptPressed: { _ in })
}
