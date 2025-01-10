//
//  GoogleSignInRepositoryProtocol.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 08/01/2025.
//

import Foundation
import UIKit
protocol GoogleSignInRepositoryProtocol {
    var  isSignedIn:Bool { get }
    func signIn(presenting viewController: UIViewController) async
    func signOut()
}


