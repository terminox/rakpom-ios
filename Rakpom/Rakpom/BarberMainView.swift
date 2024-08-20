//
//  BarberMainView.swift
//  Rakpom
//
//  Created by CatMeox on 20/8/2567 BE.
//

import SwiftUI

struct BarberMainView: View {
  
  @State private var stackPath: [AnyHashable] = []
  
  var body: some View {
    NavigationStack(path: $stackPath) {
      BarberMainTabView()
        .navigationDestination(for: AnyHashable.self) { destination in
          
          switch destination.base {

          
          default:
            EmptyView()
          }
        }
    }
  }
}

#Preview {
  BarberMainView()
}
