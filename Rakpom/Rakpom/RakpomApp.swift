//
//  RakpomApp.swift
//  Rakpom
//
//  Created by CatMeox on 17/5/2567 BE.
//

import Firebase
import FirebaseAuth
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

  func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    #if DEBUG || STAGING
    Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
    #else
    Auth.auth().setAPNSToken(deviceToken, type: .prod)
    #endif
  }

  func application(
    _: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
  {
    if Auth.auth().canHandleNotification(userInfo) {
      completionHandler(.noData)
      return
    }
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if Auth.auth().canHandle(url) {
      return true
    }
    
    return false
  }
}
