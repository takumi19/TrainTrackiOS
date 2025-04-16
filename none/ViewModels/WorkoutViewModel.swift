//
//  WorkoutViewModel.swift
//  none
//
//  Created by Max Vaughan on 12.04.2025.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var workout: Workout

    init(workout: Workout) {
        self.workout = workout
    }

    func AddExercise(exercise: Exercise) {

    }
}
