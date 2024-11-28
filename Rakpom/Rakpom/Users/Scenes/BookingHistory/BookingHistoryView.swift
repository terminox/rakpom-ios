//
//  PointView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

struct BookingHistoryView: View {
  
  @ObservedObject var viewModel: BookingHistoryViewModel
  
  var body: some View {
    let items = viewModel.items
    
    VStack(spacing: 0) {
      TitleView(title: "ประวัติการใช้บริการ", color: .white)
      
      ScrollView {
        VStack(spacing: 8) {
          ForEach(items) { item in
            BookingHistoryItemView(item: item)
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
    .task {
      await viewModel.fetch()
    }
  }
}

struct BookingHistoryItemView: View {
  
  let item: BookingHistoryItem
  
  var body: some View {
    HStack(spacing: 16) {
      AsyncImage(url: item.imageURL) { image in
        image
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 95)
          .clipShape(RoundedRectangle(cornerRadius: 4))
      } placeholder: {
        Rectangle()
          .foregroundStyle(.halfGray)
          .frame(width: 100, height: 95)
          .clipShape(RoundedRectangle(cornerRadius: 4))
      }
      .frame(width: 100, height: 95)
      .clipShape(RoundedRectangle(cornerRadius: 4))
      
      VStack(alignment: .leading, spacing: 6) {
        Text(item.name)
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)
        
        Label(item.location, image: .location)
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundColor(.darkGray)
          .lineLimit(1)
        
        Text(item.description)
          .font(.custom("Noto Sans Thai", size: 12))
          .foregroundStyle(.black)
      }
      
      VStack {
        Text(item.price)
          .font(.custom("Noto Sans Thai", size: 18))
          .foregroundStyle(.black)
          .fontWeight(.bold)
          .padding(.top, 8)
        
        Spacer()
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .frame(height: 129)
    .background(.white)
    .padding(.top, 5)
    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
  }
}
