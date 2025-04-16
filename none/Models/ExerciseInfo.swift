//
//  ExerciseInfo.swift
//  none
//
//  Created by Max Vaughan on 15.04.2025.
//

import Foundation

struct ExerciseInfo: Identifiable, Codable {
    var id: Int
    var name: String
    var notes: String?
    var isRepBased: Bool
    var isBodyweight: Bool
    var muscleGroups: [String]
}
