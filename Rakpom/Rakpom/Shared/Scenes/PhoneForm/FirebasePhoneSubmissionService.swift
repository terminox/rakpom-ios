//
//  AlamofirePhoneSubmissionService.swift
//  Rakpom
//
//  Created by yossa on 23/11/2567 BE.
//

import FirebaseAuth
import Foundation

class FirebasePhoneSubmissionService: PhoneSubmissionService {

  // MARK: Lifecycle

  init(auth: Auth = .auth()) {
    self.auth = auth
    auth.languageCode = "th"
    
    #if DEBUG
    auth.settings?.isAppVerificationDisabledForTesting = true
    #endif
  }

  // MARK: Internal

  struct InvalidVerificationIDError: Error { }

  let auth: Auth

  func submit(phone: String) async throws -> PhoneFormResponse {
    try await withCheckedThrowingContinuation { continuation in
      let provider = PhoneAuthProvider.provider(auth: auth)
      provider.verifyPhoneNumber(phone) { verificationID, error in
        if let error = error {
          return continuation.resume(throwing: error)
        }

        guard let verificationID = verificationID else {
          return continuation.resume(throwing: InvalidVerificationIDError())
        }

        let response = PhoneFormResponse(refCode: verificationID)
        return continuation.resume(returning: response)
      }
    }
  }
}
