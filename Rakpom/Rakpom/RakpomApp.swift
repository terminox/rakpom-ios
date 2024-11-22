//
//  RakpomApp.swift
//  Rakpom
//
//  Created by CatMeox on 17/5/2567 BE.
//

import Firebase
import SwiftUI

// MARK: - RakpomApp

@main
struct RakpomApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

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

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
