//
//  AlamofireRootInitialStateAdapterShopProfileService.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import Foundation

// MARK: - AlamofireRootInitialStateAdapterShopProfileService

class AlamofireRootInitialStateAdapterShopProfileService: RootInitialStateAdapterShopProfileService {
  func verifyShopProfile() async throws {
    // TODO
    throw NSError(domain: "", code: -1)
  }
}

//// Automatic String to URL conversion, Swift concurrency support, and automatic retry.
//let response = await AF.request("https://httpbin.org/get", interceptor: .retryPolicy)
//                       // Automatic HTTP Basic Auth.
//                       .authenticate(username: "user", password: "pass")
//                       // Caching customization.
//                       .cacheResponse(using: .cache)
//                       // Redirect customization.
//                       .redirect(using: .follow)
//                       // Validate response code and Content-Type.
//                       .validate()
//                       // Produce a cURL command for the request.
//                       .cURLDescription { description in
//                         print(description)
//                       }
//                       // Automatic Decodable support with background parsing.
//                       .serializingDecodable(DecodableType.self)
//                       // Await the full response with metrics and a parsed body.
//                       .response
//// Detailed response description for easy debugging.
//debugPrint(response)
