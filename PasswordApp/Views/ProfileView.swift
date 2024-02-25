//
//  ProfileView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/19/24.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack {
                if let user = viewModel.user{
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        @AppStorage("use_face_id") var useFaceID: Bool = false
        
        @KeyChain(key: "use_face_email", account: "FaceIDLogin") var storedEmail
        @KeyChain(key: "use_face_password", account: "FaceIDLogin") var storedPassword
        
        
        // Avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        // Info: Name, Email, Member Since
        VStack(alignment: .leading){
            HStack{
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding()
            HStack{
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding()
            HStack{
                Text("Member Since: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        }
        .padding()
        
        
        VStack{
            // logout button
            TLButton(title: "Logout", background: .blue){
                try? Auth.auth().signOut()
            }
            .padding()
            .frame(maxHeight: 100)
            
            
            // disable face id button
            if useFaceID{
                // Clearing Face Id
                TLButton(title: "Disable Face ID", background: .blue){
                    useFaceID = false
                    storedEmail = nil
                    storedPassword = nil
                }
                .padding()
            }
        }
        .padding(.bottom, 50)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
