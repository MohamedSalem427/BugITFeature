//
//  ContentView.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import SwiftUI

struct BugReportScreen: View {
    @StateObject private var viewModel:BugReportViewModel
    init(viewModel: BugReportViewModel = BugReportViewModel()) {
           _viewModel = StateObject(wrappedValue: viewModel)
       }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    descriptionTextField
                    Divider()
                    SelectImageScreenshotButton(
                        title: Strings.selectScreenshot,
                        systemImageName: .photo,
                        systemImageForegroundColor: .blue,
                        verticalPadding: 8) {
                            viewModel.showingImagePicker = true
                        }
                    Divider()
                    SelectImageScreenshotButton(
                        title: Strings.captureScreenshot,
                        systemImageName: .userRectangle,
                        systemImageForegroundColor: .blue,
                        verticalPadding: 8) {
                            viewModel.inputImage = captureScreenshoot()
                        }
                    Divider()
                    imagePreview
                    submitButton
                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
            }
            .padding(.horizontal , 16)
            .navigationTitle(Strings.bugTracker)
            .onAppear { viewModel.onAppear() }
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePickerView(image: $viewModel.inputImage)
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text(Strings.ok)))
            }
        }.dismissKeyboardOnTap()
    }
    
    private var descriptionTextField: some View {
        TextField(Strings.enterDescription, text: $viewModel.description)
            .padding(.vertical, 16)
    }
    
    private var selectImageButton: some View {
        Button(action: {
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
        .padding(.vertical,10)
    }
}

#Preview {
    BugReportScreen(viewModel: BugReportViewModel())
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
