//
//  Config.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import Foundation

struct Config {
  #if DEBUG
  static let apiURL: URL = URL(string: "http://127.0.0.1:8000/api/v1")!
  #elseif STAGING
  static let apiURL: URL = URL(string: "https://rakpom-staging-f5b1aec57070.herokuapp.com/api/v1")!
  #else
  static let apiURL: URL = URL(string: "http://127.0.0.1:8000/api/v1")!
  #endif
}
