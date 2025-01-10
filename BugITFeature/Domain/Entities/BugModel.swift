//
//  BugModel.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import Foundation
import SwiftData

@Model
class BugModel {
    @Attribute(.externalStorage)
    var imageData: Data
    
    var desc: String = ""
    
    init(imageData: Data, description: String) {
        self.imageData = imageData
        self.desc = description
    }
}
