//
//  FirebaseTokenManager.swift
//  Rakpom
//
//  Created by yossa on 23/11/2567 BE.
//

import FirebaseAuth
import Foundation

class FirebaseTokenManager {

  // MARK: Lifecycle

  init(auth: Auth = .auth()) {
    self.auth = auth
  }

  // MARK: Internal

  struct InvalidTokenError: Error { }

  func getFirebaseAuthToken() async throws -> String {
    try await withCheckedThrowingContinuation { continuation in
      auth.getToken(forcingRefresh: true) { token, error in
        if let error = error {
          return continuation.resume(throwing: error)
        }

        guard let token = token else {
          return continuation.resume(throwing: InvalidTokenError())
        }

        return continuation.resume(returning: token)
      }
    }
  }

  // MARK: Private

  private let auth: Auth

}
