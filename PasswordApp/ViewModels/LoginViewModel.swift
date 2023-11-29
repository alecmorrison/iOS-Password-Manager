//
//  LoginViewModel.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/12/23.
//
import SwiftUI
import Firebase
import FirebaseAuth
import LocalAuthentication

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    //Face ID properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    //Keychain properties
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword
    
    // Log Status
    // @AppStorage("login_status") var logStatus: String = ""
    
    
    // Error
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    
    // Firebase login
    func loginUser(useFaceID: Bool, email: String = "", password: String = "")async throws{
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email: self.email, password: password != "" ? password: self.password)
        
        DispatchQueue.main.async{
            if useFaceID && self.storedEmail == nil{
                self.useFaceID = useFaceID
                
                let emailData = self.email.data(using: .utf8)
                let passwordData = self.password.data(using: .utf8)
                self.storedEmail = emailData
                self.storedPassword = passwordData
                print("Stored")
            }

            //self.logStatus = "home"
        }
        
    }
    
    //Face ID Usage
    func getBioMetricStats()->Bool{
        let scanner = LAContext()
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    //Face ID Login
    func authenticateUser()async throws{
        let status =  try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Login")
        if let emailData = storedEmail, let passwordData = storedPassword, status{
            try await loginUser(useFaceID: useFaceID, email: String(data: emailData, encoding: .utf8) ?? "", password: String(data: passwordData, encoding: .utf8) ?? "")
        }
    }
}
