//
//  ChatsView.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

// Views/ChatsView.swift
import SwiftUI
import Combine

struct ChatView: View {
    @StateObject var viewModel = MessageViewModel()
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
                    .onReceive(Just(viewModel.messages)) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.messages.last, anchor: .bottom)
                        }
                    }
                    .onAppear {
                        withAnimation {
                            proxy.scrollTo(viewModel.messages.last, anchor: .bottom)
                        }
                    }
                }
            }
            
            // Input field and send button
            HStack {
                TextField("Send a message", text: $viewModel.newMessage)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: viewModel.sendMessage) {
                    Image(systemName: "paperplane")
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
}

#Preview {
    ChatView()
        .environmentObject(MessageViewModel())
}
