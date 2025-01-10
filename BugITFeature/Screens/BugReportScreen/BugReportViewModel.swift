//
//  BugReportViewModel.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//
import Combine
import UIKit

class BugReportViewModel: ObservableObject {
    
    @Published var description: String = ""
    @Published var inputImage: UIImage? = nil
    @Published var showingImagePicker: Bool = false
    @Published var showingAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var alertTitle: String = ""
    
    var isSubmitButtonDisabled: Bool {
        description.isEmpty || inputImage == nil
    }
    
    private let bugReportUseCase:BugReportUseCasesProtocol
    private let signInUseCase:SignInUseCaseProtocol
    
    
    init(
        bugReportUseCase: BugReportUseCasesProtocol =  BugReportUseCases(),
        signInUseCase:SignInUseCaseProtocol = SignInUseCases()
    ) {
        self.bugReportUseCase = bugReportUseCase
        self.signInUseCase = signInUseCase
    }
    
    func onAppear() {
        signIn()
    }
    func signIn(){
        Task {
            guard let scene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = await scene.windows.first,
                  let rootViewController = await window.rootViewController else {
                return
            }
            do {
                try await signInUseCase.signIn(presenting: rootViewController)
            } catch {
                print("Error during sign-in: \(error.localizedDescription)")
            }
        }
    }
    func submitBug() {
        guard signInUseCase.isUserSignedIn else {
            signIn()
            return
        }
        
        guard let inputImage = inputImage, let imageData = inputImage.jpegData(compressionQuality: 0.1) else {
            showAlert(title: Strings.submissionError, message: Strings.noImageSelectedOrProcessed)
            return
        }
        Task {
            do {
                try await bugReportUseCase.submitBugReport(description: description, imageData: imageData)
                resetData()
                
                showAlert(title: Strings.submissionSuccessful, message: Strings.bugReportSuccessfullyUploaded)
            } catch {
                showAlert(title: Strings.submissionFailed, message: Strings.failedToUploadBugReport)
            }
        }
    }
    private func showAlert(title: String,
                           message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showingAlert = true
    }
    
    private func resetData() {
        self.inputImage = nil
        self.description = ""
    }
}
