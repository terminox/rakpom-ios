//
//  CustomerMainView.swift
//  Rakpom
//
//  Created by CatMeox on 24/7/2567 BE.
//

import SwiftUI

struct CustomerMainView: View {
  @State private var stackPath: [AnyHashable] = []
  
  var body: some View {
    NavigationStack(path: $stackPath) {
      CustomerMainTabView()
        .navigationDestination(for: AnyHashable.self) { destination in
          switch destination.base {
            // HOME
          case let b as HomeScreen:
            HomeView(id: b.id)
              .navigationBarBackButtonHidden(true)
          case let c as SettingsScreen:
            SettingsView(id: c.id)
              .navigationBarBackButtonHidden(true)
          case _ as PointScreen:
            YourPointView()
              .navigationBarBackButtonHidden(true)
            
            // BOOKING
          case let booking as RecentBookingItem:
            ReservationView(id: booking.id)
              .navigationBarBackButtonHidden(true)
          case let x as BookingItem:
            ReservationView(id: x.id)
              .navigationBarBackButtonHidden(true)
          case let item as ConfirmationLayoutItem:
            ConfirmReservationView(confirm: item, stackPath: $stackPath)
              .navigationBarBackButtonHidden(true)
          case let item as BookingReviewsNavItem:
            ReviewView(id: item.bookingID)
              .navigationBarBackButtonHidden(true)
          
            // PAYMENT
          case let paymentMethod as PaymentMethod:
            if paymentMethod.type == "Scan" {
              ScanConfirmView(type: "Scan")
                .navigationBarBackButtonHidden(true)
            } else if paymentMethod.type == "Cash" {
              CashConfirmView(type: "Cash")
                .navigationBarBackButtonHidden(true)
            } else {
              PointConfirmView(type: "Point")
                .navigationBarBackButtonHidden(true)
            }
            
            // SETTINGS
          case _ as Profile:
            ProfileSettingsView()
              .navigationBarBackButtonHidden(true)
          case _ as AboutUs:
            AboutUsView()
              .navigationBarBackButtonHidden(true)
          case _ as PrivacyPolicy:
            PrivacyPolicyView()
              .navigationBarBackButtonHidden(true)
          case _ as Terms:
            TermsView()
              .navigationBarBackButtonHidden(true)
          case _ as UserGender:
            GenderSelectionView()
              .navigationBarBackButtonHidden(true)
            
          default:
            EmptyView()
          }
        }
    }
  }
}

#Preview {
  CustomerMainView()
}
