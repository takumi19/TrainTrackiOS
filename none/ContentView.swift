//
//  ContentView.swift
//  none
//
//  Created by Max Vaughan on 13.03.2025.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color("SecondaryBg"))

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ChatsView(viewModel: ChatViewModel())
                .tabItem {
                    Image(systemName: "message.fill")
                }
                .tag(0)

//            HistoryView(workouts: HistoryViewModel())
            HistoryView()
                .background(Color("PrimaryBg"))
                .tabItem {
                    Image(systemName: "doc.text.fill")
                }
                .tag(1)

            ProgramsView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
                .tag(3)
        }
        .accentColor(Color("PrimaryColor"))
    }
}

#Preview {
    ContentView()
}
