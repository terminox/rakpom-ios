//
//  PointListView.swift
//  Rakpom
//
//  Created by CatMeox on 31/5/2567 BE.
//

import SwiftUI

// MARK: - PointListView

struct PointListView: View {

  @ObservedObject var viewModel: PointListViewModel

  var body: some View {
    VStack {
      if let profile = viewModel.userProfile {
        PointListContentView(profile: profile)
      } else {
        Spacer()

        ProgressView()
          .progressViewStyle(.circular)

        Spacer()
      }
    }
    .task {
      await viewModel.onAppear()
    }
  }
}

// MARK: - PointListContentView

struct PointListContentView: View {

  let profile: PointsUserProfile

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        HStack(spacing: 4) {
          Image(.coin)
            .resizable()
            .scaledToFit()
            .frame(width: 26, height: 26)

          Text("\(profile.totalPoints) แต้ม")
            .font(.custom("Noto Sans Thai", size: 30))
            .fontWeight(.bold)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
        }
        .frame(width: geo.size.width * 0.5, height: 54)
        .background(Color.white)
        .clipShape(Capsule())
        .foregroundColor(Color("Black"))
        .frame(maxWidth: .infinity)
        .padding(.bottom, 32)
        .background(.blueApp)

        HStack {
          Image("User")
            .resizable()
            .frame(width: 53, height: 53)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.blueBG, lineWidth: 2.5))

          VStack(alignment: .leading) {
            Text("สวัสดี! \(profile.fullName)")
              .font(.custom("Noto Sans Thai", size: 18))
              .foregroundStyle(.black)

            Text("รหัสสมาชิก : \(profile.memberID)")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.gray)
          }

          Spacer()
        }
        .padding(24)

        Divider()
        
        ScrollView {
          ForEach(profile.points) { item in
            PointListItemView(item: item)
            
            Divider()
          }
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

// MARK: - PointListItemView

struct PointListItemView: View {

  let item: ProfilePoint

  var body: some View {
    HStack {
      Image(.coin)
        .resizable()
        .scaledToFit()
        .frame(width: 26, height: 26)

      Text("\(item.point) แต้ม")
        .font(.custom("Noto Sans Thai", size: 15))
        .foregroundStyle(.black)

      Spacer()

      Text(item.dateString)
        .font(.custom("Noto Sans Thai", size: 15))
        .foregroundStyle(.halfGray)
    }
    .padding(.horizontal, 30)
    .padding()
  }
}

#Preview {
  let avatarURL = URL(string: "https://unsplash.com/photos/grayscale-photo-of-man-c_GmwfHBDzk")!
  let name = "ยศภาส"
  let memberID = "239958"
  let points = [
    ProfilePoint(id: UUID().uuidString, point: 100, dateString: "16/11/2567 11:29"),
    ProfilePoint(id: UUID().uuidString, point: 200, dateString: "16/11/2567 11:29"),
    ProfilePoint(id: UUID().uuidString, point: 300, dateString: "16/11/2567 11:29"),
    ProfilePoint(id: UUID().uuidString, point: 400, dateString: "16/11/2567 11:29"),
    ProfilePoint(id: UUID().uuidString, point: 500, dateString: "16/11/2567 11:29"),
  ]

  let profile = PointsUserProfile(avatarURL: avatarURL, fullName: name, memberID: memberID, totalPoints: 1_500, points: points)

  BackScaffold(title: "แต้มของคุณ") {
    PointListContentView(profile: profile)
  }
}
