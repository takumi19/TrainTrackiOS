//
//  ContentView.swift
//  none
//
//  Created by Max Vaughan on 13.03.2025.
//

import Combine
import SwiftUI

struct ContentView: View {

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
        TabView {
            Text("People")
                .tabItem {
                    Image(systemName: "person.2.fill")
                }

            ChatsView(viewModel: ChatViewModel())
                .tabItem {
                    Image(systemName: "message.fill")
                }

            HistoryView(workouts: HistoryViewModel(workouts: [testingWorkout, testingWorkout, testingWorkout1, testingWorkout1, testingWorkout]))
                .background(Color("PrimaryBg"))
                .tabItem {
                    Image(systemName: "doc.text.fill")
                }

            ProgramsView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }
        }
        .accentColor(Color("PrimaryColor"))
    }
}

#Preview {
    ContentView()
}
