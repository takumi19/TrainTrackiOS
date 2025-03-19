//
//  Task.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Foundation

struct Workout: Identifiable {
    var id = UUID()
    var date: Date
    var templateName: String? // If part of a program
    var duration: TimeInterval
    var exercises: [Exercise]
}

struct Exercise: Identifiable {
    var id = UUID()
    var name: String
    var movementType: MovementType
    var resistanceType: ResistanceType
    var sets: [SetDetail]
}

enum MovementType {
    case Dynamic
    case Static
}

enum ResistanceType {
    case weighted
    case bodyweight
}

struct SetDetail: Identifiable {
    var id = UUID()
    var repetitions: Int? // For dynamic exercises
    var duration: TimeInterval? // For static exercises
    var weight: Double? // For weighted exercises
    var rpe: Int? // Optional
}
