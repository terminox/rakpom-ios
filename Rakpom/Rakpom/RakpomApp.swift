//
//  RakpomApp.swift
//  Rakpom
//
//  Created by CatMeox on 17/5/2567 BE.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    return true
  }
}

@main
struct RakpomApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  
  var body: some Scene {
    WindowGroup {
      CustomerMainView()
    }
  }
}
