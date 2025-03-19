//
//  Task.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: Int64
    var fullName: String
    var login: String
    var email: String
    var passwordHash: String
}
