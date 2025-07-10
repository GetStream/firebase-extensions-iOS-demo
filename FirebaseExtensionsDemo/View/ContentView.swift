//
//  ContentView.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 09.07.25.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    
    @State var viewModel = AuthViewModel()
    
    var body: some View {
        switch viewModel.authState {
        case .loading:
            ZStack {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .error(let message):
            ZStack {
                Text(message)
                    .foregroundStyle(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .signedIn(let userId):
            ChatView(userId: userId)
        case .signedOut:
            LoginView(viewModel: viewModel)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
