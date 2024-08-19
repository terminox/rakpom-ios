//
//  SearchingNumberView.swift
//  Rakpom
//
//  Created by CatMeox on 2/6/2567 BE.
//

import SwiftUI

struct SearchingNumberView: View {
  @State var firstNo: String = ""
  @State var secondNo: String = ""
  @State var thirdNo: String = ""
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        CustomerHeaderView(id: "qwerty")
        
        Text("รางวัลงวดวันที่ " + "1 ม.ค. 66" + " (ล่าง)")
          .font(.custom("Noto Sans Thai", size: 20))
          .fontWeight(.semibold)
          .padding(.top, 60)
        
        Image("Jackpot")
          .resizable()
          .frame(width: 219, height: 146)
        
        Text("ค้นหาเลข")
          .font(.custom("Noto Sans Thai", size: 18))
        
        HStack(spacing: 25) {
          TextField("", text: $firstNo)
            .limitText($firstNo, to: 1)
            .keyboardType(.numberPad)
            .padding()
            .frame(width: 45, height: 45)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
          
          TextField("", text: $secondNo)
            .limitText($secondNo, to: 1)
            .keyboardType(.numberPad)
            .padding()
            .frame(width: 45, height: 45)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
          
          TextField("", text: $thirdNo)
            .limitText($thirdNo, to: 1)
            .keyboardType(.numberPad)
            .padding()
            .frame(width: 45, height: 45)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
        }
        
        Button {
          
        } label: {
          AppButton(title: "ยืนยัน")
            .padding(75)
        }
      }
    }
    .ignoresSafeArea()
    .background(.blueBG)
  }
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { _ in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}

#Preview {
  SearchingNumberView()
}
