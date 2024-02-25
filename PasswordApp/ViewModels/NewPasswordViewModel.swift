//
//  NewPasswordViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/22/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewPasswordViewModel: ObservableObject {
    @Published var title = ""
    @Published var usernameEmail = ""
    @Published var password = ""
    @Published var showAlert = false
    
    init() {}
    
    func save() {
        
        // Get current User Id
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        // Create Model
        let newId = UUID().uuidString
        let newItem = PasswordItem(id: newId,
                                   title: title,
                                   usernameEmail: usernameEmail,
                                   password: password
                                   )
        
        //Save Model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("passwords")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard !usernameEmail.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
    
}

