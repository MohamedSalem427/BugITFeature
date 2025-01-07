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
    @Published var isLoading: Bool = false
    
    var isSubmitButtonDisabled: Bool {
        description.isEmpty || inputImage == nil
    }
    func onAppear() {
        signIn()
        getDataFromShare()
    }
    func signIn() {}
    func getDataFromShare() {}
    func submitBug() {}
}
