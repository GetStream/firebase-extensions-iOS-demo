//
//  LoginView.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 09.07.25.
//

import SwiftUI

struct LoginView: View {
    
    @State var viewModel: AuthViewModel
    
    @State private var mail = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Text("Login / Signup")
                .font(.title)
            
            Form {
                TextField("Mail", text: $mail)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .autocorrectionDisabled(true)
                    .textContentType(.password)
            }
            
            HStack {
                Button {
                    viewModel.signUp(
                        mail: mail,
                        password: password
                    )
                } label: {
                    Text("Sign Up")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button {
                    viewModel.signIn(
                        mail: mail,
                        password: password
                    )
                } label: {
                    Text("Sign In")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    LoginView(viewModel: AuthViewModel())
}
