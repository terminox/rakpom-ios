//
//  FirebaseImageUploadingService.swift
//  Rakpom
//
//  Created by yossa on 5/1/2568 BE.
//

import FirebaseAuth
import FirebaseStorage
import Foundation

// MARK: - FirebaseImageUploadingService

class FirebaseImageUploadingService: ImageUploadingService {

  // MARK: Lifecycle

  init(storage: Storage = Storage.storage(), auth: Auth = Auth.auth()) {
    self.storage = storage
    self.auth = auth
  }

  // MARK: Internal

  func uploadImage(_ imageData: Data) async throws -> URL {
    let storageRef = storage.reference()
    let fileRef = storageRef.child("images/\(auth.currentUser?.uid ?? "")/\(UUID().uuidString)")

    do {
      _ = try await fileRef.putDataAsync(imageData)
      let downloadURL = try await fileRef.downloadURL()
      return downloadURL
    } catch {
      print("FirebaseImageUploadingService error: \(error)")
      throw error
    }
  }

  // MARK: Private

  private let storage: Storage
  private let auth: Auth
  
}
