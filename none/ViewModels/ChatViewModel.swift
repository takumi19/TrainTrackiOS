//
//  TaskVM.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

// ViewModels/TaskViewModel.swift
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var chats: [ChatModel] = []
    private var user: UserModel?
    
    func fetchChatsForUser(id: Int64) async {}
    
    func getChatsNames() async -> [String] {
        var chatNames: [String] = []
        for (_, chat) in chats.enumerated() {
            chatNames.append(chat.title)
        }
        return chatNames
    }
}
