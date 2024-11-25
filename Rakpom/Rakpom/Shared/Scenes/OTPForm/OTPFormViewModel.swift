//
//  OTPFormViewModel.swift
//  Rakpom
//
//  Created by yossa on 23/11/2567 BE.
//

import Foundation

// MARK: - OTPFormViewModel

class OTPFormViewModel: ObservableObject {

  // MARK: Lifecycle

  init(refCode: String, service: any OTPService, onSuccess: @escaping (SignupState) -> Void) {
    self.refCode = refCode
    self.service = service
    self.onSuccess = onSuccess
  }

  // MARK: Internal

  let refCode: String
  let service: any OTPService
  let onSuccess: (SignupState) -> Void

  func submit(otp: String) {
    Task { @MainActor in
      let state = try await service.submit(.init(otp: otp, refCode: refCode))
      onSuccess(state)
    }
  }
}

// MARK: - OTPService

protocol OTPService {
  func submit(_ payload: OTPFormPayload) async throws -> SignupState
}

// MARK: - OTPFormPayload

struct OTPFormPayload {
  let otp: String
  let refCode: String
}
