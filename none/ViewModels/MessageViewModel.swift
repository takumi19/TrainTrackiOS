//
//  MessageViewModel.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Combine
import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = DataSource.messages
    @Published var newMessage: String = ""
    
    func addMessage(_ message: Message) {
        messages.append(message)
    }

    func getMessages() -> [Message] {
        return messages
    }
    
    func lastMessage() -> Message? {
        if messages.count > 0 {
            return messages.last
        } else {
            return nil
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messages.append(Message(content: newMessage, isCurrentUser: true))
        messages.append(Message(content: "Reply to: " + newMessage, isCurrentUser: false))
        newMessage = ""
    }
}
