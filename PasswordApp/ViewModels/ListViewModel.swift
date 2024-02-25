//  ListViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 9/10/23.


import Foundation
import FirebaseFirestore


class ListViewModel: ObservableObject {
    @Published var showingNewPasswordView = false
    @Published var showingEditPasswordView = false
    @Published var showingInfoView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    // Delete to do list Item
    func delete(id: String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("passwords")
            .document(id)
            .delete()
        
    }
}
