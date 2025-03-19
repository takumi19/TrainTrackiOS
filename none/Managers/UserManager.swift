//
//  UserManager.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import SwiftUI

class UserManager: ObservableObject {
    @Published var user: UserModel? {
        didSet {
            saveUser()
        }
    }
    
    init() {
        user = UserModel(id: 1, fullName: "AMA", login: "takumi", email: "ta@kumi.com", passwordHash: "qqqqq")
    }
    
    // should send over the data to the backend
    private func saveUser() {
        // pass
    }
    
    // Should load user data from the backend
    private func loadUser(login: String?, email: String?, pwd: String?) {
        if login != nil {
            // fetch by login if present
        } else if email != nil {
            // fetch by email
        } else {
            // error out if neither was provided
        }
    }
    
    func logout() {
        user = nil
    }
    
    func login(login: String?, email: String?, pwd: String?) {
        loadUser(login: login, email: email, pwd: pwd)
        //        user = User(id: "1", login: "testuser", email: "test@test.de")
    }
    
    func getUserId() -> Int64? {
        return user?.id
    }
    
    func isCurrentUser(userId: Int64) -> Bool {
        return user?.id == userId
    }
}
