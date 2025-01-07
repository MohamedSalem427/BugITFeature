//
//  ContentView.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import SwiftUI

struct BugReportScreen: View {
    
    @StateObject private var viewModel = BugReportViewModel()
    @FocusState private var isDescriptionFieldFocused: Bool
    
    private let notificationCenter = NotificationCenter.default
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text(Strings.bugDetails)) {
                        descriptionTextField
                        selectImageButton
                        captureScreenshot
                        imagePreview
                    }
                    submitButton
                }
                .navigationTitle(Strings.bugTracker)
                .onAppear { viewModel.onAppear() }
                .sheet(isPresented: $viewModel.showingImagePicker) {
                    ImagePickerView(image: $viewModel.inputImage)
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text(Strings.ok)))
                }
            }
        }.dismissKeyboardOnTap()
    }
    
    private var descriptionTextField: some View {
        TextField(Strings.enterDescription, text: $viewModel.description)
            .focused($isDescriptionFieldFocused)
            .padding(.vertical, 6)
    }
    
    private var selectImageButton: some View {
        Button(action: {
            isDescriptionFieldFocused = false
            viewModel.showingImagePicker = true
        }) {
            HStack {
                Image(systemName: .photo)
                    .foregroundColor(.blue)
                Text(Strings.selectScreenshot)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 6)
    }
    
    private var captureScreenshot: some View {
        Button(action: {
            viewModel.inputImage = captureScreenshoot()
        }) {
            HStack {
                Image(systemName: .userRectangle)
                    .foregroundColor(.blue)
                Text(Strings.captureScreenshot)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 6)
    }
    
    private var imagePreview: some View {
        Group {
            if let inputImage = viewModel.inputImage {
                HStack {
                    Spacer()
                    Image(uiImage: inputImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
    }
    
    private var submitButton: some View {
        Button(action: {
            isDescriptionFieldFocused = false
            viewModel.submitBug()
        }) {
            Text(Strings.submitBugReport)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isSubmitButtonDisabled ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline)
        }
        .disabled(viewModel.isSubmitButtonDisabled)
    }
}

#Preview {
    BugReportScreen()
}

extension BugReportScreen {
    func captureScreenshoot() -> UIImage? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        return renderer.image { context in
            window.layer.render(in: context.cgContext)
        }
    }
}
