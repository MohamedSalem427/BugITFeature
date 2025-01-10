//
//  BugStorageRepositoryProtocol.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation

protocol BugStorageRepositoryProtocol {
    func saveBug(_ bug: BugEntity) throws
    func loadBugs() async throws -> [BugEntity]
    func deleteAll() throws
}
