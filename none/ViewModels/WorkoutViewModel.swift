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

    func AddExercise(exerciseInfo: ExerciseInfo) {
        workout.exercises.append(self.fromExerciseInfo(exerciseInfo))
    }

    func SaveWorkout() {
        // TODO: Post the workout to the backend
    }

    private func fromExerciseInfo(_ exerciseInfo: ExerciseInfo) -> Exercise {
        Exercise(id: Int.random(in: 1000..<10000),
                name: exerciseInfo.name,
                exerciseNumber: workout.exercises.count + 1,
                movementType: exerciseInfo.isRepBased ? .Dynamic : .Static,
                resistanceType: exerciseInfo.isBodyweight ? .bodyweight : .weighted,
                bestSet: "",
                sets: [])
    }
}
