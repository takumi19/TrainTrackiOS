//
//  MessageView.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import SwiftUI

extension MessageModel {
    static func generateDummyMessages(count: Int) -> [MessageModel] {
        var messages: [MessageModel] = []
        let now = Date()
        for i in 0..<count {
            let isEven = i % 2 == 0
            let authorId: Int64 = isEven ? 1 : 0 // Alternate author IDs
            let textContent = "This is a dummy message \(i+1). " + (isEven ? "From Author 1." : "From Author 2.") + " Some more text to make it longer."
            let sentAt = now.addingTimeInterval(TimeInterval(i * 60)) // Messages sent a minute apart
            let editedAt = isEven ? now.addingTimeInterval(TimeInterval(i * 60 + 300)) : nil // Some messages are edited
            messages.append(
                MessageModel(authorId: authorId, textContent: textContent, sentAt: sentAt, editedAt: editedAt)
            )
        }
        return messages
    }
}

struct MessageCell: View {
    @State private var isCurrentUser: Bool
    @State var message: MessageModel

    init(message: MessageModel) {
        self.message = message
        self.isCurrentUser = (APIManager.shared.userId == message.authorId)
        print("Apimanager user id: \(APIManager.shared.userId), message authorid: \(message.authorId)")
    }

    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            VStack {
                Text(message.textContent)
                    .foregroundStyle(.primaryLabel)
                HStack {
                    Spacer()
                    Text("11:30")
                        .font(.caption)
                        .foregroundStyle(isCurrentUser ? Color("MsgTimeColor").opacity(0.8) : .secondaryLabel)
                }
            }
            .padding()
            .background(isCurrentUser ? Color("PrimaryColor").opacity(0.4) : Color("SecondaryBg"))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .frame(maxWidth: 250, alignment: isCurrentUser ? .trailing : .leading)
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}

#Preview {
    ScrollView {
        LazyVStack {
            ForEach(MessageModel.generateDummyMessages(count: 5)) { msg in
                MessageCell(message: msg)
            }
        }
        .padding(.horizontal)
    }
    .background(.primaryBg)
}
