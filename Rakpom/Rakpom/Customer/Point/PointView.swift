//
//  PointView.swift
//  Rakpom
//
//  Created by CatMeox on 27/5/2567 BE.
//

import SwiftUI

struct ShopItem: Identifiable {
  let id: String
  let shopName: String
  let location: String
  let description: String
  let points: Int
  let price: String
  let image: AnyView
}

struct PointView: View {
  
  @StateObject var viewModel = PointViewModel()
  
  var body: some View {
  
    let history = viewModel.history
    
    GeometryReader { geo in
      VStack(spacing: 0) {
        // HEADER
        CustomerHeaderView(id: "qwerty")
        
        TitleView(title: "ประวัติการใช้บริการ", color: .white)
        
        ScrollView {
          ForEach(history) { usage in
            HistoryItems(usage: usage)
          }
        }
      }
    }
    .background(.lightGray)
    .ignoresSafeArea()
    .task {
      await viewModel.fetchHistory()
    }
  }
}

struct HistoryItems: View {
  let usage: ShopItem
  
  var body: some View {
    HStack(spacing: 16) {
      usage.image
//              .resizable()
        .frame(width: 100, height: 95)
        .clipShape(RoundedRectangle(cornerRadius: 4))
      
      VStack(alignment: .leading, spacing: 6) {
        Text(usage.shopName)
          .font(.custom("Noto Sans Thai", size: 16))
          .foregroundStyle(.black)
      
        HStack(alignment: .firstTextBaseline, spacing: 0) {
          Image("Location")
            .resizable()
            .frame(width: 11, height: 14)
         
          Text(usage.location)
            .font(.custom("Noto Sans Thai", size: 12))
            .foregroundStyle(.darkGray)
            .lineLimit(1)
            .padding(.horizontal, 4)
        }
        
        HStack {
          Text("การใช้บริการ    :")
          Text("  " + "\(usage.description)")
        }
        .font(.custom("Noto Sans Thai", size: 12))
        .foregroundStyle(.black)
        
        HStack {
          Image("Coin")
          Text("สะสม " + "\(usage.points)" + " แต้ม")
        }
        .font(.custom("Noto Sans Thai", size: 11))
        .foregroundStyle(.black)
        .padding(4)
        .padding(.horizontal, 4)
        .background(.lightGray)
        .clipShape(Capsule())
        .padding(.top, 4)
      }
      
      VStack {
        Text("฿ " + "\(usage.price)")
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

#Preview {
  PointView()
}
