//
//  Image+SystemName.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import SwiftUI

extension Image {
    init(systemName: AppSystemImage) {
        self.init(systemName: systemName.rawValue)
    }
}
