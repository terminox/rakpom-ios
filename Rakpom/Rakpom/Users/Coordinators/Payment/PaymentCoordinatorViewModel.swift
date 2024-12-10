//
//  PaymentCoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 10/12/2567 BE.
//

import SwiftUI

// MARK: - PaymentCoordinatorViewFactory

protocol PaymentCoordinatorViewFactory {
  func makePaymentCoordinatorPaymentView(onCompleted: @escaping () -> Void) -> AnyView
  func makePaymentCoordinatorPaymentCompletionView(onConfirmed: @escaping () -> Void, onCanceled: @escaping () -> Void) -> AnyView
  func makePaymentCoordinatorFeedbackView(
    for shopCode: String,
    onConfirmed: @escaping () -> Void,
    onCanceled: @escaping () -> Void)
    -> AnyView
  func makePaymentCoordinatorFeedbackCompletionView(onCompleted: @escaping () -> Void) -> AnyView
}

// MARK: - PaymentCoordinatorViewModel

class PaymentCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(shopCode: String, factory: PaymentCoordinatorViewFactory, onCompleted: @escaping () -> Void) {
    self.shopCode = shopCode
    self.factory = factory
    self.onCompleted = onCompleted
  }

  // MARK: Internal

  typealias Node = PaymentCoordinatorNode

  let shopCode: String
  let factory: PaymentCoordinatorViewFactory
  let onCompleted: () -> Void

  @Published var path: [Node] = []

  lazy var rootView = factory.makePaymentCoordinatorPaymentView { [weak self] in
    self?.displayPaymentCompletion()
  }

  var pathPublished: Published<[Node]> { _path }
  var pathPublisher: Published<[Node]>.Publisher { $path }

  func view(for node: PaymentCoordinatorNode) -> AnyView {
    switch node {
    case .payment:
      return rootView
    case .paymentCompletion:
      return factory.makePaymentCoordinatorPaymentCompletionView(
        onConfirmed: { [weak self] in self?.displayFeedback() },
        onCanceled: { [weak self] in self?.onCompleted() })
    case .feedback:
      return factory.makePaymentCoordinatorFeedbackView(
        for: shopCode,
        onConfirmed: { [weak self] in self?.displayFeedbackCompletion() },
        onCanceled: { [weak self] in self?.onCompleted() })
    case .feedbackCompletion:
      return factory.makePaymentCoordinatorFeedbackCompletionView(onCompleted: { [weak self] in self?.onCompleted() })
    }
  }

  // MARK: Private

  private func displayPaymentCompletion() {
    path.append(.paymentCompletion)
  }

  private func displayFeedback() {
    path.append(.feedback)
  }

  private func displayFeedbackCompletion() {
    path.append(.feedbackCompletion)
  }
}

// MARK: - PaymentCoordinatorNode

enum PaymentCoordinatorNode: Hashable {
  case payment
  case paymentCompletion
  case feedback
  case feedbackCompletion
}
