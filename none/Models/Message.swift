////
////  Task.swift
////  none
////
////  Created by Max Vaughan on 16.03.2025.
////

import Foundation

struct MessageModel: Identifiable {
    var id = UUID()
    var authorId: Int64
    var textContent: String
    var sentAt: Date
    var editedAt: Date?
}
