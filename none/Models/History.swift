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

    init(id: Int, name: String, movementType: MovementType, resistanceType: ResistanceType, bestSet: String, sets: [SetDetail]) {
        self.id = id
        self.name = name
        self.movementType = movementType
        self.resistanceType = resistanceType
        self.bestSet = bestSet
        self.sets = sets
    }

    init(info: ExerciseInfo) {
        self.id = Int.random(in: 100..<1000)
        self.name = info.name
        self.resistanceType = info.isBodyweight ? .bodyweight : .weighted
        self.movementType = info.isRepBased ? .Dynamic : .Static
        self.bestSet = "90 kg x 10"
        self.sets = []
    }
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
