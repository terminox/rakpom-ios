//
//  OTPView.swift
//  Rakpom
//
//  Created by CatMeox on 14/6/2567 BE.
//

import SwiftUI

struct OTPView: View {
  @State private var pin: String = ""
  @State private var timeRemaining = 60
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    GeometryReader { geo in
      VStack {
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
            
            Text("ลงทะเบียน")
              .font(.custom("Noto Sans Thai", size: 20))
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
        
        Text("กรุณากรอก OTP ที่ส่งไปยังเบอร์โทรศัพท์ของคุณ")
          .font(.custom("Noto Sans Thai", size: 14))
          .foregroundStyle(.black)
          .padding()
        
        HStack {
          TextField("รหัส OTP", text: $pin)
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundStyle(.black)
            .padding()
          
          Text("\(timeRemaining)s")
            .font(.custom("Noto Sans Thai", size: 16))
            .foregroundColor(.halfGray)
            .padding()
        }
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .stroke(.halfGray)
        )
        .padding(.horizontal, 32)
        
        Button {
          
        } label: {
          AppButton(title: "ยืนยัน")
        }
        .padding(36)
      }
      .onReceive(timer) { time in
          if timeRemaining > 0 {
              timeRemaining -= 1
          }
      }
    }
    .background(.white)
    .ignoresSafeArea()
  }
}

#Preview {
  OTPView()
}
