//
//  ProfileView.swift
//  none
//
//  Created by Max Vaughan on 22.04.2025.
//
import SwiftUI

struct ProfileView: View {
    @AppStorage("logged_in") var logged_in: Bool = false

    var body: some View {
        Button("Log Out") {
            self.logged_in = false
        }
    }
}
