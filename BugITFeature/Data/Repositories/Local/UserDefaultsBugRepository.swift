//
//  UserDefaultsBugRepository.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation
class UserDefaultsBugManager: BugStorageRepositoryProtocol {
    
    private let userDefaults = UserDefaults.init(suiteName: "group.BugIt")
    private let bugsKey = "savedBugs"
    
    func saveBug(_ bug: BugEntity) throws {
        var savedBugs = loadBugs()
        savedBugs.append(bug)
        let encodedBugs = try JSONEncoder().encode(savedBugs)
        userDefaults?.set(encodedBugs, forKey: bugsKey)
    }
    
    func loadBugs() -> [BugEntity] {
        guard let data = userDefaults?.data(forKey: bugsKey),
              let bugs = try? JSONDecoder().decode([BugEntity].self, from: data) else {
            return []
        }
        return bugs
    }
    
    func deleteAll() throws {
        userDefaults?.set([], forKey: bugsKey)
    }
}
