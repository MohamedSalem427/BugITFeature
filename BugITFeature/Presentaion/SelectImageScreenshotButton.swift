//
//  SelectImageScreenshotButton.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 10/01/2025.
//

import SwiftUI

struct SelectImageScreenshotButton: View {
    let title: String
    let systemImageName: AppSystemImage
    let systemImageForegroundColor: Color
    let verticalPadding: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemImageName)
                    .foregroundColor(systemImageForegroundColor)
                Text(title)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, verticalPadding)
    }
}

#Preview {
    SelectImageScreenshotButton(
        title: "Select Image",
        systemImageName: .photo,
        systemImageForegroundColor: .blue,
        verticalPadding: 6) {
           print("Selected")
        }
}

