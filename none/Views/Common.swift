//
//  Common.swift
//  none
//
//  Created by Max Vaughan on 15.04.2025.
//

import SwiftUI

struct CloseButton: View {

    var body: some View {
        Button(action: {
            //  isPresented = false
            print("Pressed")
        }) {
            Image(systemName: "xmark.square.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color("PrimaryColor"), Color.black.opacity(0.3))
        }
        .frame(width: 35, height: 35) // Define frame size
    }
}

//struct AsyncImage: View {
//    @State var url: URL?
//
//    init(url: String) {
//        self.url = URL(string: url)
//    }
//}


#Preview {
    ZStack {
        Color("SecondaryBg")
            .ignoresSafeArea()

        CloseButton()
    }
}
