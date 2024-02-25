//
//  EditPasswordView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/23/24.
//

import SwiftUI

struct EditPasswordView: View {
    @ObservedObject var viewModel = EditPasswordViewModel()
    @Binding var newPasswordPresented: Bool
    
    let password: PasswordItem
    
    init(newPasswordPresented: Binding<Bool>, password: PasswordItem) {
        self._newPasswordPresented = newPasswordPresented
        self.password = password
        self.viewModel = EditPasswordViewModel(itemId: password.id, title: password.title, usernameEmail: password.usernameEmail, password: password.password)
    }
    
    
    
    var body: some View {
        VStack{
            
            Text("Edit Password")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Username/Email
                TextField("Title", text: $viewModel.usernameEmail)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                // Password
                TextField("Title", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                // Button
                TLButton(title: "Save", background: .pink){
                    if viewModel.canSave {
                        viewModel.itemId = password.id
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




struct EditPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EditPasswordView(newPasswordPresented: Binding(get:{
            return true
        }, set: { _ in
        }), password: .init(id: "123",
                        title: "Example Password",
                        usernameEmail: "Example@email.com",
                        password: "password!"
                        ))
    }
}

