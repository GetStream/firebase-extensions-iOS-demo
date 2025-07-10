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
    
    var streamChat: StreamChat?
    
    var functions = Functions.functions()
    
    var chatClient: ChatClient = {
        var config = ChatClientConfig(apiKey: .init("<your-api-key>"))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = "<your-bundle-id>"
        
        let client = ChatClient(config: config)
        return client
    }()
    
    init() {
        streamChat = StreamChat(chatClient: chatClient)
    }
    
    func connectUser(with id: String) async {
        functions.httpsCallable("ext-auth-chat-getStreamUserToken").call(["uid": id]) { [weak self] result, error in
            if let error {
                log.error("Error: \(error)")
                return
            }
            
            guard let resultString = result?.data as? String, let token = try? Token(rawValue: resultString) else {
                log.error("The result returned from the Cloud Function was malformed.")
                return
            }
            
            // Call `connectUser` on our SDK to get started.
            self?.chatClient.connectUser(
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
