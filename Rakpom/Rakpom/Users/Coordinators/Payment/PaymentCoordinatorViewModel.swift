//
//  PaymentCoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 10/12/2567 BE.
//

import SwiftUI

// MARK: - PaymentCoordinatorViewFactory

protocol PaymentCoordinatorViewFactory {
  func makePaymentCoordinatorPaymentView(for paymentMethod: PaymentMethod, onCompleted: @escaping (String) -> Void) -> AnyView
  func makePaymentCoordinatorPaymentCompletionView(onConfirmed: @escaping () -> Void, onCanceled: @escaping () -> Void) -> AnyView
  func makePaymentCoordinatorFeedbackView(
    for shopCode: String,
    onCompleted: @escaping () -> Void,
    onCanceled: @escaping () -> Void)
    -> AnyView
  func makePaymentCoordinatorFeedbackCompletionView(onCompleted: @escaping () -> Void) -> AnyView
}

// MARK: - PaymentCoordinatorViewModel

class PaymentCoordinatorViewModel: StackCoordinatorViewModel {

  // MARK: Lifecycle

  init(paymentMethod: PaymentMethod, factory: PaymentCoordinatorViewFactory, onCompleted: @escaping () -> Void) {
    self.paymentMethod = paymentMethod
    self.factory = factory
    self.onCompleted = onCompleted
  }

  // MARK: Internal

  typealias Node = PaymentCoordinatorNode

  let paymentMethod: PaymentMethod
  let factory: PaymentCoordinatorViewFactory
  let onCompleted: () -> Void

  @Published var path: [Node] = []

  lazy var rootView = factory.makePaymentCoordinatorPaymentView(for: paymentMethod) { [weak self] in
    self?.shopCode = $0
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
      guard let shopCode = shopCode else { return AnyView(EmptyView()) }
      return factory.makePaymentCoordinatorFeedbackView(
        for: shopCode,
        onCompleted: { [weak self] in self?.displayFeedbackCompletion() },
        onCanceled: { [weak self] in self?.onCompleted() })

    case .feedbackCompletion:
      return factory.makePaymentCoordinatorFeedbackCompletionView(onCompleted: { [weak self] in self?.onCompleted() })
    }
  }

  // MARK: Private

  private var shopCode: String?

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
