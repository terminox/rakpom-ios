//
//  PhoneFormViewModel.swift
//  Rakpom
//
//  Created by yossa on 23/11/2567 BE.
//

import Foundation

// MARK: - PhoneSubmissionService

protocol PhoneSubmissionService {
  func submit(phone: String) async throws -> PhoneFormResponse
}

// MARK: - PhoneFormViewModel

class PhoneFormViewModel: ObservableObject {

  // MARK: Lifecycle

  init(service: any PhoneSubmissionService, onSuccess: @escaping (PhoneFormResponse) -> Void) {
    self.service = service
    self.onSuccess = onSuccess
  }

  // MARK: Internal

  let service: any PhoneSubmissionService
  let onSuccess: (PhoneFormResponse) -> Void

  func submit(phone: String) {
    Task { @MainActor in
      let response = try await service.submit(phone: phone)
      onSuccess(response)
    }
  }
}
