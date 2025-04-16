//
//  Task.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Foundation

struct Workout: Identifiable {
    var id: Int                // Id of the workout
    var date: Date             // Date of execution
    var templateName: String?   // If part of a program
    var weekNumber: Int?       // number of the week in the program it belongs to
    var tonnage: Int           // Tonnage in kilograms
    var prCount: Int?          // Number of PRs in the workout
    var name: String           // Name of the workout
    var notes: String?         // Notes on the workout
    var duration: Int  // Duration of the workout in seconds
    var exercises: [Exercise]   // Exercises of the workout
}

struct Exercise: Identifiable {
    var id: Int
    var name: String
    var exerciseNumber: Int
    var movementType: MovementType
    var resistanceType: ResistanceType
    var bestSet: String
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
    var id: Int
    var setNumber: Int
    var rpe: Int? // Optional

    var suggestedRepsMin: Int?
    var suggestedRepsMax: Int?
    var suggestedReps: Int? // For dynamic exercises

    var suggestedTimeMin: Int?
    var suggestedTimeMax: Int?
    var suggestedTime: Int? // For dynamic exercises

    var reps: Int?
    var duration: Int? // For static exercises
    var weight: Double? // For weighted exercises

    var notes: String?
}
