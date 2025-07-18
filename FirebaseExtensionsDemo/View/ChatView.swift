//
//  ChatView.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 09.07.25.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ChatView: View {
    
    @Injected(\.chatClient) var chatClient: ChatClient
    
    var userId: String
    
    @State private var viewModel = ChatViewModel()
    
    var body: some View {
        ChatChannelListView()
            .task {
                await viewModel.connectUser(with: userId, to: chatClient)
            }
    }
}

#Preview {
    ChatView(userId: "Stefan")
}
