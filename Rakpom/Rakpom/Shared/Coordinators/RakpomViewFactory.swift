//
//  RakpomViewFactory.swift
//  Rakpom
//
//  Created by yossa on 19/11/2567 BE.
//

import Alamofire
import SwiftUI

// MARK: - RakpomViewFactory

class RakpomViewFactory {

  lazy var tokenManager = FirebaseTokenManager()
  lazy var client = RakpomAlamofireWrapper(tokenManager: tokenManager)

  func makeRootView() -> AnyView {
    let viewModel = RootViewModel(factory: self)
    
    let userURL = Config.apiURL.appending(path: "users/profiles/me")
    let userProfileService = AlamofireRootInitialStateAdapterUserProfileService(url: userURL, client: client)
    
    let shopProfileService = AlamofireRootInitialStateAdapterShopProfileService()
    
    let adapter = RootInitialStateAdapter(
      userProfileService: userProfileService,
      shopProfileService: shopProfileService)
    adapter.viewModel = viewModel

    let view = RootView(viewModel: viewModel)
      .task {
        await adapter.fetchInitialState()
      }

    return AnyView(view)
  }
}
