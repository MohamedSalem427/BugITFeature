//
//  FirebaseStorageRepository.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation
import FirebaseStorage

class FirebaseStorageRepository: FirebaseStorageRepositoryProtocol {
    func uploadImage(imageData: Data) async throws -> URL {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let ref = Storage.storage().reference(withPath: "\(UUID().uuidString).jpg")
        return try await save(data: imageData, reference: ref, meta: meta)
    }
    
    private func save(data: Data,
                      reference: StorageReference,
                      meta: StorageMetadata) async throws -> URL {
        let _ = try await reference.putDataAsync(data, metadata: meta)
        return try await reference.downloadURL()
    }
    
    enum FirebaseStorageError: Error {
        case unableToConvertToData
    }
}
