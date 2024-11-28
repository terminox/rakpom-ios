//
//  PaymentMethodSelectionView.swift
//  Rakpom
//
//  Created by CatMeox on 28/5/2567 BE.
//

import SwiftUI

struct PaymentMethod: Hashable {
  let type: String
}

struct PaymentMethodSelectionView: View {
  @State var isScanSelected: Bool = false
  @State var isCashSelected: Bool = false
  @State var isPointSelected: Bool = false
  
  @State var type: String = ""
  
  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        TitleView(title: "ยืนยันการชำระเงิน", color: .white)
        
        Text("เลือกการชำระเงินของคุณ")
          .font(.custom("Noto Sans Thai", size: 18))
          .foregroundStyle(.black)
          .padding(28)
        
        VStack(spacing: 20) {
          Button {
            isScanSelected = true
            isCashSelected = false
            isPointSelected = false
            
            type = "Scan"
          } label: {
            OptionButton(title: "ชำระด้วยการแสกน", isSelected: isScanSelected, width: geo.size.width / 1.3)
          }
          
          Button {
            isScanSelected = false
            isCashSelected = true
            isPointSelected = false
            
            type = "Cash"
          } label: {
            OptionButton(title: "ชำระด้วยเงินสด", isSelected: isCashSelected, width: geo.size.width / 1.3)
          }
          
          Button {
            isScanSelected = false
            isCashSelected = false
            isPointSelected = true
            
            type = "Point"
          } label: {
            OptionButton(title: "ชำระด้วยแต้มสะสม", isSelected: isPointSelected, width: geo.size.width / 1.3)
          }
        }
        
        NavigationLink(value: AnyHashable(PaymentMethod(type: type))) {
          AppButton(title: "ถัดไป")
            .padding(36)
        }
      }
    }
    .background(.blueBG)
    .ignoresSafeArea()
  }
}

#Preview {
  PaymentMethodSelectionView()
}
