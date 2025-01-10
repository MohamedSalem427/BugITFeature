//
//  SignInUseCases.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 09/01/2025.
//

import UIKit
protocol SignInUseCaseProtocol {
    var isUserSignedIn: Bool { get }
    func signIn(presenting viewController: UIViewController) async throws
    func signOut()
}
 
class SignInUseCases: SignInUseCaseProtocol {
    private let googleSignInRepo: GoogleSignInRepositoryProtocol

    init(googleSignInRepo: GoogleSignInRepositoryProtocol = GoogleSignInRepository()) {
        self.googleSignInRepo = googleSignInRepo
    }
    var isUserSignedIn: Bool {
        return googleSignInRepo.isSignedIn
    }

    func signIn(presenting viewController: UIViewController) async throws {
        await googleSignInRepo.signIn(presenting: viewController)
    }

    func signOut() {
        googleSignInRepo.signOut()
    }
}
