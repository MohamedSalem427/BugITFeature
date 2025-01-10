//
//  FirebaseStorageRepositoryProtocol.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation

protocol FirebaseStorageRepositoryProtocol {
    func uploadImage(imageData: Data) async throws -> URL
}
