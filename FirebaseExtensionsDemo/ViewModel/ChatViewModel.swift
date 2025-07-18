//
//  ChatViewModel.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 10.07.25.
//

import Foundation
import StreamChat
import StreamChatSwiftUI
import FirebaseFunctions

@Observable
class ChatViewModel {
    
    var functions = Functions.functions()
    
    func connectUser(with id: String, to client: ChatClient) async {
        functions.httpsCallable("ext-auth-chat-getStreamUserToken").call(["uid": id]) { result, error in
            if let error {
                log.error("Error: \(error)")
                return
            }
            
            guard let resultString = result?.data as? String, let token = try? Token(rawValue: resultString) else {
                log.error("The result returned from the Cloud Function was malformed.")
                return
            }
            
            // Call `connectUser` on our SDK to get started.
            client.connectUser(
                userInfo: .init(
                    id: id,
                ),
                token: token
            ) { error in
                if let error = error {
                    // Some very basic error handling only logging the error.
                    log.error("connecting the user failed \(error)")
                    return
                }
            }
        }
    }
}
