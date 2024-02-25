//
//  NewPasswordView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/22/24.
//

import SwiftUI

struct NewPasswordView: View {
    @StateObject var viewModel = NewPasswordViewModel()
    @Binding var newPasswordPresented: Bool
    
    var body: some View {
        VStack{
            Text("New Password")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Username/Email
                TextField("Username/Email", text: $viewModel.usernameEmail)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                // Password
                TextField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                // Button
                TLButton(title: "Save", background: .pink){
                    if viewModel.canSave {
                        viewModel.save()
                        newPasswordPresented = false
                    } else{
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please Fill in all Fields"))
            }
        }
    }
}


struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView(newPasswordPresented: Binding(get:{
            return true
        }, set: { _ in
        }))
    }
}

