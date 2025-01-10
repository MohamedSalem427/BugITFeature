//
//  Environment.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 10/01/2025.
//

import Foundation

struct Environment {
    enum Keys {
        static let apiKey = "API_KEY"
    }
    static let apiKey: String = {
        guard let baseURLProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.apiKey
        ) as? String else {
            fatalError("API_KEY not found")
        }
        return baseURLProperty
    }()
}
