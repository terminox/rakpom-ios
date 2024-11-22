//
//  RootViewModel.swift
//  Rakpom
//
//  Created by yossa on 19/11/2567 BE.
//

import SwiftUI

// MARK: - RootViewFactory

protocol RootViewFactory {
  func makeRootSplashView() -> AnyView
  func makeRootSignupView(onSignupCompleted: @escaping (SignupResult) -> Void) -> AnyView
  func makeRootUserProfileFormView(onCompleted: @escaping () -> Void) -> AnyView
  func makeRootShopProfileFormView(onCompleted: @escaping () -> Void) -> AnyView
  func makeRootMainView(onLogout: @escaping () -> Void) -> AnyView
  func makeRootShopMainView(onLogout: @escaping () -> Void) -> AnyView
}

// MARK: - RootViewModel

class RootViewModel: ObservableObject {

  // MARK: Lifecycle

  init(factory: any RootViewFactory) {
    self.factory = factory
  }

  // MARK: Internal

  let factory: any RootViewFactory

  @Published var anyView: AnyView?

  lazy var initialView: AnyView = factory.makeRootSplashView()
  
  func onAppear() {
    displaySplash()
  }
  
  func displaySplash() {
    anyView = initialView
  }

  func displaySignup() {
    anyView = factory.makeRootSignupView(onSignupCompleted: { [weak self] result in
      switch (result.registrationType, result.signupState) {
      case (.user, .profile):
        self?.displayUserProfileForm()
      case (.user, .completed):
        self?.displayMain()
      case (.shop, .profile):
        self?.displayUserProfileForm()
      case (.shop, .completed):
        self?.displayShopMain()
      }
    })
  }

  func displayUserProfileForm() {
    anyView = factory.makeRootUserProfileFormView(onCompleted: { [weak self] in self?.displayMain() })
  }

  func displayShopProfileForm() {
    anyView = factory.makeRootShopProfileFormView(onCompleted: { [weak self] in self?.displayShopMain() })
  }

  func displayMain() {
    anyView = factory.makeRootMainView(onLogout: { [weak self] in self?.displaySignup() })
  }

  func displayShopMain() {
    anyView = factory.makeRootShopMainView(onLogout: { [weak self] in self?.displaySignup() })
  }
}

// MARK: - SignupResult

struct SignupResult {
  let registrationType: RegistrationType
  let signupState: SignupState
}

// MARK: - RegistrationType

enum RegistrationType {
  case user
  case shop
}

// MARK: - SignupState

enum SignupState {
  case profile
  case completed
}
