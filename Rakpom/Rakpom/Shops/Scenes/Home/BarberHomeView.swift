//
//  BarberHomeView.swift
//  Rakpom
//
//  Created by CatMeox on 14/6/2567 BE.
//

import SwiftUI

struct News: Hashable {
  let id: String
}

struct ProfileSettings: Hashable {
  let id: String
}

struct BarberHomeView: View {
  @Environment(\.dismiss) var dismiss
  
  let imageNames: [String] = ["Barber1", "Barber2", "Barber3", "Barber4"]
  
  var data: [String] = ["Barber1", "Barber2", "Barber3", "Barber4"]
  let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
  
  let id: String
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        HStack {
          HStack {
            Button {
              dismiss()
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }
            
            Text("ร้านค้าของฉัน")
              .font(.custom("Noto Sans Thai", size: 20))
              .foregroundStyle(.black)
              .padding(4)
          }
          
          Spacer()
          
          NavigationLink(value: AnyHashable(ProfileSettings(id: id))) {
            Image(systemName: "gearshape")
              .resizable()
              .frame(width: 28, height: 28)
              .foregroundColor(Color("Black"))
              .frame(width: 42, height: 42)
          }
        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 133)
        .background(.blueApp)
        
        HStack(spacing: 16) {
          Image("Barber2")
            .resizable()
            .frame(width: 65, height: 65)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(
              Circle()
                .stroke(Color.blueApp, lineWidth: 2.5))
          
          VStack(alignment: .leading) {
            Text("ร้าน" + "ลุงหนุ่ม")
              .font(.custom("Noto Sans Thai", size: 18))
              .fontWeight(.semibold)
              .foregroundStyle(.black)
            
            Text("รหัสร้านค้า :" + " " + "436577")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundStyle(.black)
          }
          
          Spacer()
          
          NavigationLink(value: AnyHashable(News(id: id))) {
            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 10, height: 17)
              .foregroundColor(.darkGray)
          }
        }
        .padding()
        .background(.blueBG)
        
        ScrollView{
          VStack(alignment: .leading, spacing: 8) {
            Text("ข้อมูลร้านค้า")
              .font(.custom("Noto Sans Thai", size: 16))
              .fontWeight(.bold)
              .foregroundStyle(.black)
            
            HStack {
              Image(systemName: "phone.fill")
                .font(.callout)
                .foregroundStyle(.blueButton)
              
              Text("095-458769")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundColor(.darkGray)
            }
            
            Text("เปิดร้าน 10:00 - 20:00 น.")
              .font(.custom("Noto Sans Thai", size: 14))
              .foregroundColor(.darkGray)
            
            HStack(alignment: .firstTextBaseline, spacing: 6) {
              Image("Location")
                .resizable()
                .frame(width: 13, height: 15)
             
              Text("35/8 ถนน งามวงศ์วาน แขวงลาดยาว เขตจตุจักร กรุงเทพมหานคร 10900")
                .font(.custom("Noto Sans Thai", size: 14))
                .foregroundStyle(.darkGray)
                .lineLimit(3)
                .padding(.horizontal, 4)
            }
          }
          .padding()
          .frame(width: geo.size.width, alignment: .leading)
          
          Divider()
            .frame(width: geo.size.width, height: 4)
            .overlay(.lightGray)
          
          VStack(alignment: .leading, spacing: 12) {
            Text("รูปภาพของฉัน")
              .font(.custom("Noto Sans Thai", size: 16))
              .fontWeight(.bold)
              .foregroundStyle(.black)
            
            LazyVGrid(columns: adaptiveColumn, spacing: 20) {
              ForEach(data, id: \.self) { item in
                Image(item)
                  .frame(width: geo.size.width / 2.3, height: 122, alignment: .center)
                  .background(.blue)
                  .cornerRadius(4)
                  .foregroundColor(.white)
                  .font(.title)
              }
            }
          }
          .padding()
          .frame(width: geo.size.width, alignment: .leading)
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  BarberHomeView(id: "asdf")
}
