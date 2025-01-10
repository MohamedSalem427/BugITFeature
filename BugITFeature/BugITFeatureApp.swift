//
//  BugITFeatureApp.swift
//  BugITFeature
//
//  Created by Mohamed Salem on 07/01/2025.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct BugITFeatureApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            BugReportScreen(viewModel: BugReportViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let handled = GIDSignIn.sharedInstance.handle(url)
        if handled { return true }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let handled = GIDSignIn.sharedInstance.handle(url)
        if handled { return true }
        return false
    }
}
