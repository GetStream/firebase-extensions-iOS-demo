//
//  ChatView.swift
//  FirebaseExtensionsDemo
//
//  Created by Stefan Blos on 09.07.25.
//

import SwiftUI
import StreamChatSwiftUI

struct ChatView: View {
    
    var userId: String
    @State private var viewModel = ChatViewModel()
    
    var body: some View {
        ChatChannelListView()
            .task {
                await viewModel.connectUser(with: userId)
            }
    }
}

#Preview {
    ChatView(userId: "Stefan")
}
