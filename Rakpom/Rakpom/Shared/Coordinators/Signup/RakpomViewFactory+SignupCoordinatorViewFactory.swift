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
  
  func makeSignupMethodSelectionView(onSignupPressed: @escaping () -> Void) -> AnyView {
    let view = SignupView(onSignupPressed: onSignupPressed)
    return AnyView(view)
  }
  
  func makeSignupPhoneFormView(back: @escaping () -> Void, registrationType: RegistrationType, onSuccess: @escaping (PhoneFormResponse) -> Void) -> AnyView {
    let service = FirebasePhoneSubmissionService()
    let viewModel = PhoneFormViewModel(service: service, onSuccess: onSuccess)
    let view = BackScaffold(back: back) {
      PhoneFormView(onSubmit: viewModel.submit)
    }
    .navigationBarBackButtonHidden()
    return AnyView(view)
  }
  
  func makeSignupOTPFormView(back: @escaping () -> Void, registrationType: RegistrationType, refCode: String, onSuccess: @escaping (SignupState) -> Void) -> AnyView {
    let service = AggregatedOTPService(url: Config.apiURL.appending(path: "users/signup/phone"))
    let viewModel = OTPFormViewModel(refCode: refCode, service: service, onSuccess: onSuccess)
    let view = BackScaffold(back: back) {
      OTPFormView(onSubmit: viewModel.submit)
    }
    .navigationBarBackButtonHidden()
    
    return AnyView(view)
  }
}
