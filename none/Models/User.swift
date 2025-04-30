//
//  Task.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: Int64 = Int64.random(in: 1000..<10000)
    var fullName: String
    var login: String
    var email: String

    init(fullName: String, username: String, email: String) {
        self.fullName = fullName
        self.login = username
        self.email = email
    }
//    var passwordHash: String
}
