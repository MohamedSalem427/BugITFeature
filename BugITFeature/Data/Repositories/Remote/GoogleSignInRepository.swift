//
//  GoogleSignInRepository.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 08/01/2025.
//

import UIKit
import GoogleSignIn

class GoogleSignInRepository: GoogleSignInRepositoryProtocol {
    private(set) var isSignedIn: Bool = false
    func signIn(presenting viewController: UIViewController) async {
        do {
            // Attempt to restore previous sign-in
            _ = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
            isSignedIn = true
        } catch {
            do {
                _ = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController,
                                                              hint: nil,
                                                              additionalScopes: Constants.additionalScopes)
                isSignedIn = true
            } catch {
                print("Error with signing in: \(error.localizedDescription)")
                isSignedIn = false
            }
        }
    }
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        isSignedIn = false
    }
}
