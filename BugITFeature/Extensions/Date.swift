//
//  Date.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation
extension Date {
    func getCurrentDateFormatted(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}

