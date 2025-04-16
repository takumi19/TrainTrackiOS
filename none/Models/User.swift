//
//  Task.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: Int64?
    var fullName: String
    var username: String
    var email: String

    init(fullName: String, username: String, email: String) {
        self.fullName = fullName
        self.username = username
        self.email = email
    }
//    var passwordHash: String
}
