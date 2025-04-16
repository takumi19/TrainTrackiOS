//
//  noneApp.swift
//  none
//
//  Created by Max Vaughan on 13.03.2025.
//

import SwiftUI

@main
struct noneApp: App {
//    @StateObject var userManager: UserManager = UserManager()
    
    // TODO: Optionally load some data from last saved session
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
//                .environmentObject(userManager)
        }
    }
}
