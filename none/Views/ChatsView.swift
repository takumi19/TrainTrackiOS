//
//  ChatsView.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import SwiftUI
import Foundation

struct User: Identifiable, Equatable {
    let id: String
    let name: String
    let avatarURL: String
}

struct Message: Identifiable {
    let id = UUID()
    let senderId: String
    let text: String
    let timestamp: Date
}

struct Chat: Identifiable {
    let id: String
    let participantIds: [String]
    var lastMessage: Message
}

struct ChatsView: View {
    @ObservedObject var viewModel: ChatViewModel
    let currentUserId = "u1"

//    init(viewModel: ChatViewModel) {
//        self.viewModel = viewModel
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 36, weight: .bold, width: .condensed)]
//    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { index in
                    NavigationLink(value: index) {
                        ChatCard()
                    }
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.primaryBg)
            .navigationTitle(Text("Chats"))
//            .navigationBarTitleDisplayMode(.automatic)
            .navigationDestination(for: Int.self) { arg in
                ChatView()
            }
        }
    }
}

struct ChatCard: View {
//    @State var chat: Chat

    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(maxWidth: 32, maxHeight: 32)
//                .frame(alignment: .centerFirstTextBaseline)
                .clipShape(Circle())

            Spacer().frame(maxWidth: 12)

            VStack(alignment: .leading, spacing: 12) {
                Text("Name")
                    .font(.headline)
                Text("lorem ipsum i dont know what the hell i am writing i do not remember this fucking latin placeholder text what the actual hell")
                    .font(.subheadline)
                    .foregroundStyle(.secondaryLabel)
                    .lineLimit(1)
            }
            Spacer()
            VStack {
                Text("9:41")
                    .font(.caption)
                    .foregroundStyle(.secondaryLabel)
                Spacer()
            }
            .padding(.top, 12)
        }
        .frame(maxHeight: 70)
        .listRowSeparator(Visibility.visible)
        .listRowBackground(Color.clear)
        .listRowSpacing(16)
    }
}

#Preview {
    ChatsView(viewModel: ChatViewModel())
}
