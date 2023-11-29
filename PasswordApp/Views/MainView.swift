//
//  ContentView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/10/23.
//

import SwiftUI

struct MainView: View {
    // Log Status
    // @AppStorage("login_status") var logStatus: String = ""
    @StateObject var viewModel = MainViewModel()
    
    @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
    
    var body: some View {
        
        NavigationView{
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                //signed in state
                HomeView()
                    .onTapGesture {
                        print(storedEmail as Any)
                    }
            }
            else{
                LoginView()
                    .navigationBarHidden(true)
                    .onTapGesture {
                        print(storedEmail as Any)
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
