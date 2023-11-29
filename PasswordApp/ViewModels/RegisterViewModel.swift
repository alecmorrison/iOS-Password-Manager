//
//  RegisterViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 8/13/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init() {}
    
    // Create User ID
    func register() {
        guard validate() else{
            return
        }
        
        // CRETAE USER
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userID = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userID)
        }
        
    }
    
    
    //Input to DataBase
    private func insertUserRecord(id: String){
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    
    
    // Validate function
    private func validate() -> Bool {
        // Make sure fields are not empty
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        //proper email
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        //proper password
        guard password.count >= 6 else {
            return false
        }
        
        return true
    }
    
    
}



