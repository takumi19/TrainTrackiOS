//
//  ContentView.swift
//  none
//
//  Created by Max Vaughan on 13.03.2025.
//

import Combine
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("People")
                .tabItem {
                    Label("People", systemImage: "person.2.fill")
                }
            
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
            
            LogsView()
                .tabItem {
                    Label("Log", systemImage: "doc.text.fill")
                }

            Text("Templates View")
                .tabItem {
                    Label("Templates", systemImage: "square.grid.2x2.fill")
                }
            
            Text("Profile View")
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
