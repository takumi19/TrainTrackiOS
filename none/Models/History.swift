//
//  Task.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

import Foundation

struct Workout: Identifiable, Hashable, Codable {
    var id: Int = Int.random(in: 0..<10000)                // Id of the workout
    var date: Date = Date.now             // Date of execution

    // These three are either all present or all absent
    var templateName: String?   // If part of a program
    var weekNumber: Int?       // number of the week in the program it belongs to
    var workoutNumber: Int?       // number of the workout in the program it belongs to

    var tonnage: Int = 0           // Tonnage in kilograms
    var prCount: Int = 0          // Number of PRs in the workout
    var name: String = "New Workout"           // Name of the workout
    var notes: String?         // Notes on the workout
    var duration: Int?  // Duration of the workout in seconds
    var exercises: [Exercise] = []   // Exercises of the workout
}

struct Exercise: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
    var movementType: MovementType
    var resistanceType: ResistanceType
    var bestSet: String
    var sets: [SetDetail]
}

enum MovementType: Int, Codable {
    case Dynamic
    case Static
}

enum ResistanceType: Int, Codable {
    case weighted
    case bodyweight
}

struct SetDetail: Identifiable, Hashable, Codable {
    var id: Int = Int.random(in: 100..<1000)
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

//struct Workout: Identifiable, Hashable, Codable {
//    var id: Int                // Id of the workout
//    var date: Date             // Date of execution
//    var templateName: String?   // If part of a program
//    var weekNumber: Int?       // number of the week in the program it belongs to
//    var tonnage: Int           // Tonnage in kilograms
//    var prCount: Int?          // Number of PRs in the workout
//    var name: String           // Name of the workout
//    var notes: String?         // Notes on the workout
//    var duration: Int  // Duration of the workout in seconds
//    var exercises: [Exercise]   // Exercises of the workout
//}
//
//struct Exercise: Identifiable, Hashable, Codable {
//    var id: Int
//    var name: String
//    var exerciseNumber: Int
//    var movementType: MovementType
//    var resistanceType: ResistanceType
//    var bestSet: String
//    var sets: [SetDetail]
//}
//
//enum MovementType: Int, Codable {
//    case Dynamic
//    case Static
//}
//
//enum ResistanceType: Int, Codable {
//    case weighted
//    case bodyweight
//}
//
//struct SetDetail: Identifiable, Hashable, Codable {
//    var id: Int
////    var setNumber: Int
//    var rpe: Int? // Optional
//
//    var suggestedRepsMin: Int?
//    var suggestedRepsMax: Int?
//    var suggestedReps: Int? // For dynamic exercises
//
//    var suggestedTimeMin: Int?
//    var suggestedTimeMax: Int?
//    var suggestedTime: Int? // For dynamic exercises
//
//    var reps: Int?
//    var duration: Int? // For static exercises
//    var weight: Double? // For weighted exercises
//
//    var notes: String?
//}
