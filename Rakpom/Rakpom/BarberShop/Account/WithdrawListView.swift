//
//  WithdrawListView.swift
//  Rakpom
//
//  Created by CatMeox on 25/6/2567 BE.
//

import SwiftUI

struct WithdrawListView: View {
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        HStack {
          HStack {
            Button {
              // Back
            } label: {
              Image(systemName: "arrow.left")
                .resizable()
                .frame(width: 24, height: 20)
                .foregroundColor(.black)
            }
            
            Text("ประวัติการถอนเงิน")
              .font(.custom("Noto Sans Thai", size: 20))
              .foregroundStyle(.black)
              .padding()
          }
          
          Spacer()
          
          Image("Logo")
        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 133)
        .background(.blueApp)
        
        ScrollView {
          VStack(alignment: .leading) {
            Text("20 ก.พ. 67")
              .font(.custom("Noto Sans Thai", size: 16))
              .bold()
              .foregroundStyle(.black)
              .padding(.vertical, 8)
            
            HStack(spacing: 20) {
              Image(systemName: "arrow.left.arrow.right")
                .resizable()
                .frame(width: 23, height: 25)
                .bold()
                .padding()
                .foregroundColor(.white)
                .frame(width: 66, height: 66)
                .background(.blueButton)
                .clipShape(RoundedRectangle(cornerRadius: 8))
              
              VStack(alignment: .leading) {
                Text("ถอนเงิน")
                Text("17:00" + " น.")
                  .foregroundStyle(.gray)
              }
              .font(.custom("Noto Sans Thai", size: 16))
              .foregroundStyle(.black)
              
              Spacer()
              
              Text("฿ " + "200")
                .font(.custom("Noto Sans Thai", size: 22))
                .fontWeight(.medium)
                .foregroundStyle(.black)
            }
          }
          .padding(.horizontal, 25)
          
          Divider()
        }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  WithdrawListView()
}
