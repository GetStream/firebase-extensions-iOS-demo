//
//  FirebaseExtensionsDemoApp.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 09.07.25.
//

import SwiftUI
import FirebaseCore
import StreamChat
import StreamChatSwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct FirebaseExtensionsDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var streamChat: StreamChat?
    
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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}
