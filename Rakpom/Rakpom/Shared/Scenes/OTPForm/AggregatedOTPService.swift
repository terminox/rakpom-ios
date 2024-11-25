//
//  AggregatedOTPService.swift
//  Rakpom
//
//  Created by yossa on 23/11/2567 BE.
//

import Alamofire
import FirebaseAuth
import Foundation

// MARK: - AggregatedOTPService

class AggregatedOTPService: OTPService {

  // MARK: Lifecycle

  init(url: URL, auth: Auth = .auth()) {
    self.url = url
    self.auth = auth

    #if DEBUG
    auth.settings?.isAppVerificationDisabledForTesting = true
    #endif
  }

  // MARK: Internal

  struct MissingPhoneNumberError: Error { }

  let url: URL
  let auth: Auth

  func submit(_ payload: OTPFormPayload) async throws -> SignupState {
    let provider = PhoneAuthProvider.provider(auth: auth)
    let credential = provider.credential(withVerificationID: payload.refCode, verificationCode: payload.otp)
    let result = try await auth.signIn(with: credential)

    guard let phoneNumber = result.user.phoneNumber else {
      throw MissingPhoneNumberError()
    }

    let headers = HTTPHeaders([.init(name: "Content-Type", value: "application/json")])
    let body = Body(phone: phoneNumber)
    let response = try await AF.request(
      url,
      method: .post,
      parameters: body,
      encoder: JSONParameterEncoder.default,
      headers: headers,
      interceptor: .retryPolicy)
      .validate()
      .serializingDecodable(RemoteResponse<RemoteOTPResponse>.self)
      .response.result.get()

    if let errorMessage = response.error {
      throw RemoteError(message: errorMessage)
    }

    guard let data = response.data else {
      throw MissingRemoteDataError()
    }

    return data.status.toLocal()
  }

  // MARK: Private

  private struct Body: Encodable {
    let phone: String
  }

  private struct RemoteOTPResponse: Decodable {
    let status: RemoteSignupState
  }

  private enum RemoteSignupState: String, Decodable {
    case profile
    case completed

    func toLocal() -> SignupState {
      switch self {
      case .profile:
        return .profile
      case .completed:
        return .completed
      }
    }
  }

}
