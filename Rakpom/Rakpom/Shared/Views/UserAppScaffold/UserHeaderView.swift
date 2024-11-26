//
//  UserHeaderView.swift
//  Rakpom
//
//  Created by yossa on 26/11/2567 BE.
//

import SwiftUI

struct UserHeaderView: View {
  
  let user: AppScaffoldUser?
  let onAvatarPressed: () -> Void
  let onPointPressed: () -> Void
  
  var body: some View {
    HStack {
      if let user = user {
        HStack {
          Button {
            onAvatarPressed()
          } label: {
            AsyncImage(url: user.avatarURL) { image in
              image
                .resizable()
                .frame(width: 53, height: 53)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
            } placeholder: {
              Image(.user)
                .resizable()
                .frame(width: 53, height: 53)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
            }
          }
          .buttonStyle(.plain)
          
          VStack(alignment: .leading, spacing: 4) {
            Text("สวัสดี! \(user.name)")
              .font(.custom("Noto Sans Thai", size: 18))
            
            Button {
              onPointPressed()
            } label: {
              HStack(spacing: 4) {
                Image(.coin)
                
                Text("\(user.points) แต้ม")
                  .font(.custom("Noto Sans Thai", size: 16))
              }
              .padding(.vertical, 2)
              .padding(.horizontal, 8)
              .background(Color.white)
              .clipShape(Capsule())
            }
            .buttonStyle(.plain)
          }
          .foregroundStyle(.black)
        }
      } else {
        ProgressView()
          .progressViewStyle(.circular)
      }
      
      Spacer()
      
      HStack(alignment: .center, spacing: 0) {
//        NavigationLink(value: AnyHashable(HomeScreen(id: id))) {
//          Image(systemName: "house")
//            .resizable()
//            .frame(width: 25, height: 22)
//            .foregroundColor(Color("Black"))
//            .frame(width: 42, height: 42)
//            .background(Color.white.opacity(0.7))
//            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//        }
//        .padding(.top, -8)
        
        Image(.logo)
      }
    }
    .padding()
//    .padding(.top, 40)
    .frame(maxWidth: .infinity)
//    .frame(height: 133)
    .background(.blueApp)
  }
}

#Preview {
  let user = AppScaffoldUser(name: "จอห์น โด", avatarURL: URL(string: "http://notworking.com")!, points: 1200)
  UserHeaderView(user: user, onAvatarPressed: {}, onPointPressed: {})
}

#Preview {
  UserHeaderView(user: nil, onAvatarPressed: {}, onPointPressed: {})
}
