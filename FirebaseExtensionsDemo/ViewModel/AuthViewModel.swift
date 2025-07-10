//
//  AuthViewModel.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 09.07.25.
//

import SwiftUI
import FirebaseAuth

@Observable
class AuthViewModel {
    
    private(set) var authState = AuthState.loading
    
    var handle: (any NSObjectProtocol)?
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user {
                print("Signed in: \(user.uid)")
                self.authState = .signedIn(userId: user.uid)
            } else {
                print("Currently not signed in.")
                self.authState = .signedOut
            }
        }
    }
    
    func signIn(mail: String, password: String) {
        Auth.auth().signIn(withEmail: mail, password: password) { [weak self] authResult, error in
            if let error {
                self?.authState = .error(message: "Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let userId = authResult?.user.uid else { return }
            self?.authState = .signedIn(userId: userId)
        }
    }
    
    func signUp(mail: String, password: String) {
        Auth.auth().createUser(withEmail: mail, password: password) { [weak self] authResult, error in
            if let error {
                self?.authState = .error(message: "Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let userId = authResult?.user.uid else { return }
            self?.authState = .signedIn(userId: userId)
        }
    }
    
    func removeAuthStateListener() {
        guard let handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
}
