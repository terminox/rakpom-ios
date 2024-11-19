//
//  RakpomApp.swift
//  Rakpom
//
//  Created by CatMeox on 17/5/2567 BE.
//

import SwiftUI

@main
struct RakpomApp: App {
  
  let viewFactory = RakpomViewFactory()
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  
  var body: some Scene {
    WindowGroup {
      viewFactory.makeRootView()
    }
  }
}
