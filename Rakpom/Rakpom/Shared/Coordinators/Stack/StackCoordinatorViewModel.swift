//
//  CoordinatorViewModel.swift
//  Rakpom
//
//  Created by yossa on 1/12/2567 BE.
//

import SwiftUI

protocol StackCoordinatorViewModel<Node>: ObservableObject {
  associatedtype Node: Hashable
  
  var path: [Node] { get set }
  var pathPublished: Published<[Node]> { get }
  var pathPublisher: Published<[Node]>.Publisher { get }
  
  var rootView: AnyView { get }
  
  func view(for node: Node) -> AnyView
}
