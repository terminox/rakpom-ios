//
//  AlamofireWithdrawRequestService.swift
//  Rakpom
//
//  Created by yossa on 3/1/2568 BE.
//

import Alamofire
import Foundation

// MARK: - AlamofireWithdrawRequestService

class AlamofireWithdrawRequestService: ShopWithdrawRequestService {

	// MARK: Lifecycle

	init(endpointURL: URL, tokenManager: FirebaseTokenManager) {
		self.endpointURL = endpointURL
		self.tokenManager = tokenManager
	}

	// MARK: Internal

	func createWithdrawRequest() async throws -> WithdrawRequestResult {
		let token = try await tokenManager.getFirebaseAuthToken()
		let request = AF.request(
      endpointURL.appending(path: "shops/withdraw-requests"),
			method: .post,
			headers: [
				"Authorization": "Bearer \(token)",
				"Content-Type": "application/json"
			]
		)
		let data = try await request.serializingData().value
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		let response = try decoder.decode(RemoteResponse<WithdrawRequestResponse>.self, from: data)

		if let error = response.error {
			throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error])
		}

		guard let withdrawRequestResponse = response.data else {
			throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
		}

		return WithdrawRequestResult(
			id: withdrawRequestResponse.id,
			amount: withdrawRequestResponse.amount
		)
	}

	// MARK: Private

	private let endpointURL: URL
	private let tokenManager: FirebaseTokenManager
}

// MARK: - WithdrawRequestResponse

struct WithdrawRequestResponse: Codable {
	let id: String
	let amount: Double
	let createdAt: String
}
