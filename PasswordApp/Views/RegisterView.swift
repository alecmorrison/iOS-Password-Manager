//
//  RegisterView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 8/13/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: RegisterViewModel = RegisterViewModel()
    //@AppStorage("login_status") var logStatus: String = ""
    
    
    var body: some View {
        ZStack{
            
            
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
                    .offset(y:-50)
                
                Text("Start Saving")   // Login prompt
                    .font(.largeTitle)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.016, brightness: 0.256))
                    .offset(y:-50)
                    
                
                
                // LOGIN EMAIL TEXT FIELD
                TextField("Full Name", text: $viewModel.name)
                    .padding()
                    .background {
                        
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.75))
                    }
                    .textInputAutocapitalization(.never)
                    .padding(.top,20)
                    .tint(.white)
                
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
                
                
                // LOGIN BUTTON
                Button{
                    // REGISTER
                    viewModel.register()
                } label: {
                    Text("Create Account")
                    //.fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,10)
                        .background{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.brown)
                        }
                }
                .padding(.top,15)
                .disabled(viewModel.name == "" || viewModel.email == "" || viewModel.password == "")
                .opacity(viewModel.name == "" || viewModel.email == "" || viewModel.password == "" ? 0.75 : 1)
                
            }
            .padding(.horizontal,50)
        }
        .navigationBarBackButtonHidden()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
