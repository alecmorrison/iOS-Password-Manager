//
//  HomeView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/12/23.
//

import SwiftUI
import Firebase

struct HomeView: View {
    // Log Status
    // @AppStorage("login_status") var logStatus: String = ""
    
    //Face ID properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword

    
    var body: some View {
        VStack{
            Text("Successfully Logged in")
            
            Button("Logout"){
                try? Auth.auth().signOut()
                //logStatus = ""
            }
            if useFaceID{
                // Clearing Face Id
                Button("Disable Face ID"){
                    useFaceID = false
                    storedEmail = nil
                    storedPassword = nil
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
