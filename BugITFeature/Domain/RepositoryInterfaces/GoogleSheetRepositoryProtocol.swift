//
//  GoogleSheetRepositoryProtocol.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 08/01/2025.
//

import Foundation

protocol GoogleSheetRepositoryProtocol {
    func submitBugReport(description: String, imageURL: String) async throws
}
