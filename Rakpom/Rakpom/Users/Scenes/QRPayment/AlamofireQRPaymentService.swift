//
//  AlamofireQRPaymentService.swift
//  Rakpom
//
//  Created by yossa on 8/12/2567 BE.
//

import Foundation

class AlamofireQRPaymentService: QRPaymentService {

  // MARK: Lifecycle

  init(url: URL, client: RakpomAlamofireWrapper) {
    self.url = url
    self.client = client
  }

  // MARK: Internal

  let url: URL
  let client: RakpomAlamofireWrapper

  func submitQRPayment(payload _: QRPaymentPayload) async throws {
    // TODO
  }
}
