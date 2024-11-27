//
//  PrizeListView.swift
//  Rakpom
//
//  Created by CatMeox on 2/6/2567 BE.
//

import SwiftUI

// MARK: - PrizeListView

struct PrizeListView: View {

  @ObservedObject var viewModel: PrizeListViewModel

  var body: some View {
    let items = viewModel.items

    GeometryReader { geo in
      VStack(spacing: 8) {
        ForEach(items) { item in
          PrizeListItemView(title: item.title, value: item.value, width: geo.size.width)
        }
      }
      .frame(width: geo.size.width)
      .padding(.vertical, 30)
    }
    .background(.white)
    .ignoresSafeArea()
    .task {
      await viewModel.fetch()
    }
  }
}

// MARK: - PrizeListItemView

struct PrizeListItemView: View {

  let title: String
  let value: String
  let width: Double

  var body: some View {
    VStack(spacing: 8) {
      Text(title)
        .font(.custom("Noto Sans Thai", size: 20))
        .fontWeight(.semibold)
        .foregroundStyle(.black)

      Text(value)
        .font(.custom("Noto Sans Thai", size: 16))
        .foregroundStyle(.black)
        .frame(width: width * 0.5, height: 42, alignment: .center)
        .background(.blueBG)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
  }
}

// MARK: - PrizeListServiceStub

private struct PrizeListServiceStub: PrizeListService {
  @MainActor
  func fetchPrizeItems() async throws -> [PrizeItem] {
    [.init(title: "รหัสงวดวันที่ 20 ม.ค. 66", value: "2 1 1")]
  }
}

#Preview {
  let service = PrizeListServiceStub()
  PrizeListView(viewModel: PrizeListViewModel(service: service))
}
