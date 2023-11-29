//
//  LoginView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 7/10/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    //Face ID properties
    @State var useFaceID: Bool = false
    
    var body: some View {
        ZStack {
            // blurred background image
            Image("portrait")
                .resizable()
                //.scaledToFill()
                .ignoresSafeArea()
                .blur(radius:7)
            
            // login VStack
            VStack{
                Image("lockicon")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                Text("Hello, Login Now")   // Login prompt
                    .font(.largeTitle)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.016, brightness: 0.256))
                
                
                // LOGIN EMAIL TEXT FIELD
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background {


                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.75))
                    }
                    .textInputAutocapitalization(.never)
                    .padding(.top,20)
                    .tint(.white)
                
                
                // LOGIN PASSWORD TEXT FIELD
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background {


                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.75))
                    }
                    .textInputAutocapitalization(.never)
                    .padding(.top,15)
                    .tint(.white)
                
                // Prompt user to store login creds
                if viewModel.getBioMetricStats(){
                    Group {
                        if viewModel.useFaceID{
                            Button {
                                //MARK: do face ID action
                                Task{
                                    do{
                                        try await viewModel.authenticateUser()
                                    }
                                    catch{
                                        viewModel.errorMsg = error.localizedDescription
                                        viewModel.showError.toggle()
                                    }
                                }

                            } label: {
                                VStack(alignment: .leading, spacing: 10){
                                    Label{
                                        Text("Use FaceID to login to previous account")
                                    } icon: {
                                        Image(systemName: "faceid")
                                    }
                                    .font(.caption)
                                    .foregroundColor(.white)

                                    Text("Note: You can turn off in settings")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        else{
                            Toggle(isOn: $useFaceID) {
                                Text("Use FaceID to Login")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.vertical,20)
                }
                
                
                // LOGIN BUTTON
                Button{
                    Task{
                        do{
                            try await viewModel.loginUser(useFaceID: useFaceID)
                        }
                        catch{
                            viewModel.errorMsg = "Incorrect Username or Password"
                            viewModel.showError.toggle()
                        }
                    }
                } label: {
                    Text("Login")
                        //.fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,50)
                        .background{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.brown)
                        }
                }
                .padding(.top,15)
                .disabled(viewModel.email == "" || viewModel.password == "")
                .opacity(viewModel.email == "" || viewModel.password == "" ? 0.75 : 1)
                
                
                
                // CREATE NEW USER BUTTON
                NavigationLink{
                    // MARK: CREATE ACCOUNT
                    
                    //viewModel.toRegisterView()
                    RegisterView()
                    
                        
                } label: {
                    Text("New User? Create Account")
                        .foregroundColor(.white)
                }
                .padding(.top,50)
                
            }
            .padding(.horizontal,25)
            .alert(viewModel.errorMsg, isPresented: $viewModel.showError) {
                
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
