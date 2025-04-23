import Foundation

class ChatViewModel: ObservableObject {
    @Published var users: [User] = [
        User(id: "u1", name: "You", avatarURL: "https://example.com/you.jpg"),
        User(id: "u2", name: "M", avatarURL: "https://example.com/m.jpg"),
        User(id: "u3", name: "K", avatarURL: "https://example.com/k.jpg")
    ]

    @Published var chats: [Chat] = [
        Chat(
            id: "c1",
            participantIds: ["u1", "u3"],
            lastMessage: Message(
                senderId: "u3",
                text: "I got u, appreciate it brother",
                timestamp: ISO8601DateFormatter().date(from: "2025-04-17T10:06:00Z")!
            )
        ),
        Chat(
            id: "c2",
            participantIds: ["u1", "u2"],
            lastMessage: Message(
                senderId: "u2",
                text: "New message",
                timestamp: ISO8601DateFormatter().date(from: "2025-04-17T09:41:00Z")!
            )
        )
    ]

    @Published var messages: [String: [Message]] = [
        "c1": [
            Message(senderId: "u3", text: "Hey! I decided to try out your modified PPL program with a bro day, loving it so far!", timestamp: ISO8601DateFormatter().date(from: "2025-04-17T09:41:00Z")!),
            Message(senderId: "u1", text: "Happy to hear that! How many weeks have you finished already?", timestamp: ISO8601DateFormatter().date(from: "2025-04-17T09:50:00Z")!),
            Message(senderId: "u1", text: "If you have any questions, just lmk!", timestamp: ISO8601DateFormatter().date(from: "2025-04-17T09:50:30Z")!),
            Message(senderId: "u3", text: "I got u, appreciate it brother", timestamp: ISO8601DateFormatter().date(from: "2025-04-17T10:06:00Z")!)
        ]
    ]

    func getUser(by id: String) -> User? {
        users.first { $0.id == id }
    }

    func getChatPartner(from chat: Chat, currentUserId: String) -> User? {
        let partnerId = chat.participantIds.first { $0 != currentUserId }
        return getUser(by: partnerId ?? "")
    }
}
