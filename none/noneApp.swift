//
//  noneApp.swift
//  none
//
//  Created by Max Vaughan on 13.03.2025.
//

import SwiftUI

@main
struct noneApp: App {
    @AppStorage("logged_in") var logged_in: Bool = true
    var body: some Scene {
        WindowGroup {
            if logged_in {
                ContentView()
                    .preferredColorScheme(.dark)
            } else {
                LoginView()
            }
        }
    }
}
