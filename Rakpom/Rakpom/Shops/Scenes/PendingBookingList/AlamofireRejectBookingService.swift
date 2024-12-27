//
//  AlamofireRejectBookingService.swift
//  Rakpom
//
//  Created by yossa on 19/12/2567 BE.
//

import Foundation
import Alamofire

class AlamofireRejectBookingService: RejectBookingService {
  
  // MARK: Lifecycle
  
  init(baseURL: URL, tokenManager: FirebaseTokenManager) {
    self.baseURL = baseURL
    self.tokenManager = tokenManager
  }
  
  // MARK: Internal
  
  func rejectBooking(_ bookingItem: PendingBookingItem) async throws -> [PendingBookingItem] {
    do {
      let token = try await tokenManager.getFirebaseAuthToken()
      
      let headers: HTTPHeaders = [
        "Authorization": "Bearer \(token)"
      ]
      
      let response = try await AF.request(
        baseURL.appendingPathComponent("shops/booking-requests/\(bookingItem.id)/reject"),
        method: .post,
        headers: headers
      ).serializingDecodable(RemoteResponse<[RemoteBookingRequestItem]>.self).value
      
      if let error = response.error {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
      }
      
      return response.data?.map { item in
        PendingBookingItem(
          id: item.id,
          name: item.fullName,
          dateString: item.date,
          timeString: item.time,
          imageURL: URL(string: "https://unsplash.com/photos/grayscale-photo")! // TODO
        )
      } ?? []
    } catch {
      throw error
    }
  }
  
  // MARK: Private
  
  private let baseURL: URL
  private let tokenManager: FirebaseTokenManager

}
