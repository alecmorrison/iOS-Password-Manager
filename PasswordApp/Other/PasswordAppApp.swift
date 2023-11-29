//
//  PasswordAppApp.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/10/23.
//

import SwiftUI
import FirebaseCore

@main
struct PasswordAppApp: App {
    // MARK: Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
