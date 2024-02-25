//
//  InfoViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class InfoViewModel: ObservableObject{
    @Published var itemId = ""
    
    @Published var title = ""
    @Published var usernameEmail = ""
    @Published var password = ""
    @Published var showAlert = false

    init() {}
    
    init(itemId: String, title: String, usernameEmail: String, password: String) {
        self.itemId = itemId
        self.title = title
        self.usernameEmail = usernameEmail
        self.password = password
    }
}

