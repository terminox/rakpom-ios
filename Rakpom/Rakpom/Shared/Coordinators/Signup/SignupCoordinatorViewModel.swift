//
//  SignupCoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 20/11/2567 BE.
//

import SwiftUI

// MARK: - SignupCoordinatorViewFactory

protocol SignupCoordinatorViewFactory {
  func makeSignupRegistrationTypeView(onSelected: @escaping (RegistrationType) -> Void) -> AnyView
  func makeSignupMethodSelectionView(onSignupPressed: () -> Void) -> AnyView

  func makeSignupPhoneFormView(
    registrationType: RegistrationType,
    onSuccess: (PhoneFormResponse) -> Void)
    -> AnyView

  func makeSignupOTPFormView(
    registrationType: RegistrationType,
    refCode: String,
    onSuccess: (SignupState) -> Void)
    -> AnyView
}

// MARK: - SignupCoordinatorViewModel

class SignupCoordinatorViewModel: ObservableObject {

  // MARK: Lifecycle

  init(factory: SignupCoordinatorViewFactory, onCompleted: @escaping (SignupResult) -> Void) {
    self.factory = factory
    self.onCompleted = onCompleted
  }
  
  // MARK: Internal

  let factory: SignupCoordinatorViewFactory
  let onCompleted: (SignupResult) -> Void

  @Published var path: [SignupCoordinatorNode] = []

  lazy var rootView = factory.makeSignupRegistrationTypeView(onSelected: { [weak self] in
    self?.displaySignupMethod(registrationType: $0)
  })

  func view(for node: SignupCoordinatorNode) -> AnyView {
    switch node {
    case .registrationType:
      return rootView
      
    case .signupMethod:
      return factory.makeSignupMethodSelectionView(onSignupPressed: { [weak self] in
        self?.displayPhoneForm()
      })
      
    case .phoneForm:
      guard let registrationType = registrationType else {
        return AnyView(EmptyView())
      }
      
      return factory.makeSignupPhoneFormView(registrationType: registrationType, onSuccess: { [weak self] response in
        self?.displayOTPForm(response: response)
      })
      
    case .otpForm:
      guard let registrationType = registrationType, let refCode = refCode else {
        return AnyView(EmptyView())
      }

      return factory.makeSignupOTPFormView(
        registrationType: registrationType,
        refCode: refCode,
        onSuccess: { [weak self] state in
          let result = SignupResult(registrationType: registrationType, signupState: state)
          self?.onCompleted(result)
        })
    }
  }

  func displaySignupMethod(registrationType: RegistrationType) {
    self.registrationType = registrationType
    path.append(.signupMethod)
  }
  
  func displayPhoneForm() {
    path.append(.phoneForm)
  }
  
  func displayOTPForm(response: PhoneFormResponse) {
    refCode = response.refCode
    path.append(.otpForm)
  }

  // MARK: Private

  private var registrationType: RegistrationType?
  private var refCode: String?
  
}

// MARK: - SignupCoordinatorNode

enum SignupCoordinatorNode: Hashable {
  case registrationType
  case signupMethod
  case phoneForm
  case otpForm
}

// MARK: - PhoenFormResponse

struct PhoneFormResponse {
  let refCode: String
}
