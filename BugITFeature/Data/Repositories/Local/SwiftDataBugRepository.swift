//
//  SwiftDataBugRepository.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation
import SwiftData

@available(iOS 17.0, *)
class SwiftDataBugRepository: BugStorageRepositoryProtocol {
    private var context: ModelContext
    init() {
        self.context = try! ModelContext(.init(for: BugModel.self))
    }
    func saveBug(_ bug: BugEntity) throws {
        let bugModel = BugModel(imageData: bug.imageData, description: bug.description)
        context.insert(bugModel)
        try context.save()
    }
    func loadBugs() async throws -> [BugEntity] {
        let fetchDescriptor = FetchDescriptor<BugModel>()
        let bugs = try context.fetch(fetchDescriptor)
        return bugs.map { BugEntity(description: $0.desc, imageData: $0.imageData) }
    }
    func deleteAll() throws {
        try context.delete(model: BugModel.self)
    }
}
