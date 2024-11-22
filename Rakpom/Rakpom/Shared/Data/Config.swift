//
//  Config.swift
//  Rakpom
//
//  Created by yossa on 22/11/2567 BE.
//

import Foundation

struct Config {
  #if DEBUG
  let url: URL = URL(string: "http://127.0.0.1/api/v1")!
  #elseif STAGING
  let url: URL = URL(string: "http://127.0.0.1/api/v1")!
  #else
  let url: URL = URL(string: "http://127.0.0.1/api/v1")!
  #endif
}
