//
//  AuthState.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 10.07.25.
//

import Foundation

enum AuthState {
    case loading, signedIn(userId: String), signedOut, error(message: String)
}
