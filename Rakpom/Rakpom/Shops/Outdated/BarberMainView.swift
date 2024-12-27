////
////  BarberMainView.swift
////  Rakpom
////
////  Created by CatMeox on 20/8/2567 BE.
////
//
//import SwiftUI
//
//struct BarberMainView: View {
//  
//  @State private var stackPath: [AnyHashable] = []
//  
//  var body: some View {
//    NavigationStack(path: $stackPath) {
//      BarberMainTabView()
//        .navigationDestination(for: AnyHashable.self) { destination in
//          
//          switch destination.base {
//          case let transactionType as TransactionDetail:
//            if transactionType.type == "Scan" {
//              TransferDetailView()
//                .navigationBarBackButtonHidden(true)
//            } else {
//              CashDetailView()
//                .navigationBarBackButtonHidden(true)
//            }
//            
//          case _ as WithdrawHistory:
//            WithdrawListView()
//              .navigationBarBackButtonHidden(true)
//            
//          case let item as BarberHomeScreen:
//            BarberHomeView(id: item.id)
//              .navigationBarBackButtonHidden(true)
//          case _ as News:
//            ImportantNewsView()
//              .navigationBarBackButtonHidden(true)
//          case _ as ProfileSettings:
//            ShopSettingsView()
//              .navigationBarBackButtonHidden(true)
//          default:
//            EmptyView()
//          }
//        }
//    }
//  }
//}
//
//#Preview {
//  BarberMainView()
//}
