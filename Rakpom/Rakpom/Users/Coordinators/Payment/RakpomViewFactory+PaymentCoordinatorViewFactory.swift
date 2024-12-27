//
//  RakpomViewFactory+PaymentCoordinatorViewFactory.swift
//  Rakpom
//
//  Created by yossa on 13/12/2567 BE.
//

import SwiftUI

extension RakpomViewFactory: PaymentCoordinatorViewFactory {
  func makePaymentCoordinatorPaymentView(for paymentMethod: PaymentMethod, onCompleted: @escaping (String) -> Void) -> AnyView {
    switch paymentMethod {
    case .qr:
      let url = Config.apiURL.appending(path: "users/payment/qr")
      let service = AlamofireQRPaymentService(url: url, client: client)
      let viewModel = QRPaymentViewModel(service: service, onCompleted: onCompleted)
      let view = BackScaffold(title: "การชำระ") {
        QRPaymentView(viewModel: viewModel)
      }
      .navigationBarBackButtonHidden()
      return AnyView(view)

    case .cash:
      let service = AlamofireCashPaymentService(baseURL: Config.apiURL, tokenManager: tokenManager)
      let viewModel = CashPaymentViewModel(service: service, onCompleted: onCompleted)
      let view = BackScaffold(title: "การชำระ") {
        CashPaymentView(viewModel: viewModel)
      }
      .navigationBarBackButtonHidden()
      return AnyView(view)

    case .point:
      let service = AlamofirePointPaymentService(baseURL: Config.apiURL, tokenManager: tokenManager)
      let viewModel = PointPaymentViewModel(service: service, onCompleted: onCompleted)
      let view = BackScaffold(title: "การชำระ") {
        PointPaymentView(viewModel: viewModel)
      }
      .navigationBarBackButtonHidden()
      return AnyView(view)
    }
  }

  func makePaymentCoordinatorPaymentCompletionView(
    onConfirmed: @escaping () -> Void,
    onCanceled: @escaping () -> Void)
    -> AnyView
  {
    let view = PaymentCompletionView(onConfirmed: onConfirmed, onCanceled: onCanceled)
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makePaymentCoordinatorFeedbackView(
    for shopCode: String,
    onCompleted: @escaping () -> Void,
    onCanceled: @escaping () -> Void)
    -> AnyView
  {
    let url = Config.apiURL.appending(path: "users/reviews")
    let service = AlamofireFeedbackService(shopCode: shopCode, url: url, tokenManager: tokenManager)
    let viewModel = FeedbackViewModel(service: service, onCompleted: onCompleted, onCanceled: onCanceled)
    let view = FeedbackView(viewModel: viewModel)
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }

  func makePaymentCoordinatorFeedbackCompletionView(onCompleted: @escaping () -> Void) -> AnyView {
    let view = FeedbackCompletionView(onConfirmed: onCompleted)
      .navigationBarBackButtonHidden()
    return AnyView(view)
  }
}
