//
//  RakpomViewFactory+SignupCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 20/11/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: SignupCoordinatorViewFactory {
  func makeSignupRegistrationTypeView(onSelected: @escaping (RegistrationType) -> Void) -> AnyView {
    let view = RegisterSelectionView(onSelected: onSelected)
    return AnyView(view)
  }
  
  func makeSignupMethodSelectionView(onSignupPressed: () -> Void) -> AnyView {
    let view = SignUpView()
    return AnyView(view)
  }
  
  func makeSignupPhoneFormView(registrationType: RegistrationType, onSuccess: (PhoneFormResponse) -> Void) -> AnyView {
    // TODO
    AnyView(EmptyView())
  }
  
  func makeSignupOTPFormView(registrationType: RegistrationType, refCode: String, onSuccess: (SignupState) -> Void) -> AnyView {
    // TODO
    AnyView(EmptyView())
  }
}
