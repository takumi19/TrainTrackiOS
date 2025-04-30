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
            let authorId: Int64 = isEven ? 1 : 0
            var textContent: String
            if !isEven {
                textContent = "Np! Let me know if you have any questions. How are you?"
            } else {
                textContent = "Thanks for the program, it really helped me out!"
            }
            let sentAt = now.addingTimeInterval(TimeInterval(i * 60))
            let editedAt = isEven ? now.addingTimeInterval(TimeInterval(i * 60 + 300)) : nil
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
