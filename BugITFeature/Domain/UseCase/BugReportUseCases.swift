//
//  BugReportUseCases.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation

protocol BugReportUseCasesProtocol {
    func submitBugReport(description: String,imageData: Data) async throws
    func saveBugLocally(description: String, imageData: Data) throws
    func loadLocalBugs() async throws -> [BugEntity]
    func deleteAllLocalBugs() throws
}

class BugReportUseCases: BugReportUseCasesProtocol {

    private let firebaseStorageRepo: FirebaseStorageRepositoryProtocol
    private let googleSheetRepo:GoogleSheetRepositoryProtocol
    private let bugStorageRepo: BugStorageRepositoryProtocol
    
    init(firebaseStorageRepo: FirebaseStorageRepositoryProtocol = FirebaseStorageRepository(),
         googleSheetRepo: GoogleSheetRepositoryProtocol = GoogleSheetRepository(),
         bugStorageRepo: BugStorageRepositoryProtocol = SwiftDataBugRepository()) {
        self.firebaseStorageRepo = firebaseStorageRepo
        self.bugStorageRepo = bugStorageRepo
        self.googleSheetRepo = googleSheetRepo
    }
    func submitBugReport(description: String, imageData: Data) async throws {
        let imageURL = try await firebaseStorageRepo.uploadImage(imageData: imageData)
        try await googleSheetRepo.submitBugReport(description: description, imageURL: imageURL.absoluteString )
    }
    func saveBugLocally(description: String, imageData: Data) throws {
           let bug = BugEntity(description: description, imageData: imageData)
           try bugStorageRepo.saveBug(bug)
       }
    func loadLocalBugs() async throws -> [BugEntity] {
            return try await bugStorageRepo.loadBugs()
        }
    func deleteAllLocalBugs() throws {
           try bugStorageRepo.deleteAll()
       }
}
