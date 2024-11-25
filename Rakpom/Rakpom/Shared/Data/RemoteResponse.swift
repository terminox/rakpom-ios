//
//  RemoteResponse.swift
//  Rakpom
//
//  Created by yossa on 23/11/2567 BE.
//

// MARK: - RemoteResponse

struct RemoteResponse<D: Decodable>: Decodable {
  let data: D?
  let error: String?
}
