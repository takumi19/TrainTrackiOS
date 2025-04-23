//
//  ChatDetailView.swift
//  none
//
//  Created by Max Vaughan on 21.04.2025.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    @State var newMessage: String = ""

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image("rectangle.portrait.and.arrow.right.fill")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text("Go back")
            }
        }
    }

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(MessageModel.generateDummyMessages(count: 5)) { msg in
                        MessageCell(message: msg)
                    }
                }
                .padding(.horizontal)
            }

            // MARK: Message Field
            Divider()
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .foregroundStyle(.white)
                    .textFieldStyle(.plain)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )

                Button(action: {
                    print("hi")
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(newMessage.isEmpty ? Color.gray : Color("PrimaryColor"))
                        .font(.system(size: 20))
                }
                .disabled(newMessage.isEmpty) // Disable the button if the message is empty
                .padding(.trailing, 10)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
//            .background(Color.black.opacity(0.9))
            //                            .safeAreaInset(edge: .bottom) { Color.clear } // Ensure the input stays above the keyboard
            /////
        }
        .background(.primaryBg)
        .toolbar(.hidden, for: .tabBar) 
        .navigationBarBackButtonHidden(true)
        .toolbar() {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.primaryLabel)
                })
            }
            ToolbarItem(placement: .principal) {
                Text("Name")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
        //        .navigationBarItems(leading: btnBack)
    }
}

#Preview {
    ChatView()
}
