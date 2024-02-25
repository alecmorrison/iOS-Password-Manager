//
//  InfoView.swift
//  PasswordApp
//
//  Created by Alec Morrison on 2/23/24.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var viewModel = InfoViewModel()
    @Binding var infoPresented: Bool
    
    let password: PasswordItem
    
    init(infoPresented: Binding<Bool>, password: PasswordItem) {
        self._infoPresented = infoPresented
        self.password = password
        self.viewModel = InfoViewModel(itemId: password.id, title: password.title, usernameEmail: password.usernameEmail, password: password.password)
    }
    
    
    
    var body: some View {
        VStack{
            Text(viewModel.title)
                .font(.system(size: 32))
                .bold()
                .padding(.top, 10)
            
            Text(viewModel.usernameEmail)
                .padding()
            Text(viewModel.password)
                .padding()
        }
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(infoPresented: Binding(get:{
            return true
        }, set: { _ in
        }), password: .init(id: "123",
                        title: "Example Password",
                        usernameEmail: "Example@email.com",
                        password: "password!"
                        ))
    }
}
