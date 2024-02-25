//
//  EditPasswordViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EditPasswordViewModel: ObservableObject{
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


    
    func save() {
        //save
        guard canSave else{
            return
        }
        
        // Get current User Id
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        
        
        // Create Model
        let newItem = PasswordItem(id: itemId,
                                   title: title,
                                   usernameEmail: usernameEmail,
                                   password: password
                                   )
        
        
        //Save Model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("passwords")
            .document(itemId)
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

