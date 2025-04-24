//
//  WorkoutViewModel.swift
//  none
//
//  Created by Max Vaughan on 12.04.2025.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject, Identifiable {
//    let id: Int
    @Published var workout: Workout

    // UI state
    @Published var isExpanded: Bool = false // For toggling visibility of exercises

    var id: Int {
        workout.id
    }

    var name: String {
        get { workout.name}
        set { workout.name = newValue }
    }

    var date: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: workout.date)
        }
    }
    func setDate(_ date: Date) {
        self.workout.date = date
    }

    var templateName: String {
        self.workout.templateName ?? "N/A"
    }

    var hasTemplate: Bool {
        workout.templateName != nil
    }

    var templateInfo: String {
        if let _ = workout.templateName,
           let weekNumber = workout.weekNumber,
           let workoutNumber = workout.workoutNumber {
            return "Week \(weekNumber), Workout \(workoutNumber)"
        }
        return "N/A"
    }

    var tonnage: String {
        get { "\(workout.tonnage) kg" }
        set {
            if let newTonnage = Int(newValue) {
                self.workout.tonnage = newTonnage
            }
        }
    }

    var prCount: String {
        "\(workout.prCount) PRs"
    }
    func updatePrCount(_ prCount: Int) {
        self.workout.prCount = prCount
    }

    var notes: String {
        get { workout.notes ?? "Notes" }
        set { workout.notes = newValue }
    }

    var duration: String {
        get {
            if let duration = workout.duration {
                let minutes = duration / 60
                let seconds = duration % 60
                return String(format: "%dm %ds", minutes, seconds)
            }
            return "N/A"
        }
        set {
            if let durationInt = Int(newValue) {
                self.workout.duration = durationInt
            } else {
                print("Failed to convert workout duration to Int")
            }
        }
    }

    var exercises: [ExerciseViewModel] {
        workout.exercises.map { ExerciseViewModel(exercise: $0) }
    }

    init(workout: Workout) {
        self.workout = workout
//        self.id = workout.id
    }

    func toggleExpanded() {
        isExpanded.toggle()
    }
}

class ExerciseViewModel: Identifiable {
//    let id: Int
    @Published var exercise: Exercise

    var id: Int {
        exercise.id
    }

    var name: String {
        exercise.name
    }

    var movementType: MovementType {
        exercise.movementType
    }

//    var movementType: String {
//        switch exercise.movementType {
//        case .Dynamic:
//            return "Dynamic"
//        case .Static:
//            return "Static"
//        case .none:
//            return "N/A"
//        }
//    }

    var resistanceType: ResistanceType {
        exercise.resistanceType
    }

    var isBodyweight: Bool {
        /*exercise.movementType == .Dynamic &&*/ exercise.resistanceType == .bodyweight
    }

    var trackWhat: String {
        // if dynamic -> Reps
        exercise.movementType == .Dynamic ? "Reps" : "Time"
    }

//    var resistanceType: String {
//        switch exercise.resistanceType {
//        case .weighted:
//            return "Weighted"
//        case .bodyweight:
//            return "Bodyweight"
//        default:
//            return "N/A"
//        }
//    }

    var bestSet: String {
        exercise.bestSet
    }

    var sets: [SetDetailViewModel] {
        exercise.sets.map { SetDetailViewModel(setDetail: $0) }
    }

    init(exercise: Exercise) {
        self.exercise = exercise
//        self.id = exercise.id
    }

    func recalculateBestSet() {
        if !sets.isEmpty {
//            exercise.bestSet = sets.max(by: { $0.reps < $1.reps })?.reps.map(String.init) ?? "N/A"
            exercise.bestSet = "12 x 50kg"
        }
    }

    func addEmptySet() {
        exercise.sets.append(exercise.sets.last ?? SetDetail())
    }

    func deleteSet(at index: Int) {
        guard index >= 0 && index < exercise.sets.count else { return }
        exercise.sets.remove(at: index)
    }

    func deleteSetById(_ id: Int) {
        if let index = exercise.sets.firstIndex(of: .init(id: id)) {
            deleteSet(at: index)
        }
    }
}

class SetDetailViewModel: Identifiable {
//    let id: Int
    @Published var setDetail: SetDetail

    var id: Int {
        setDetail.id
    }

    var rpe: String {
        get { setDetail.rpe.map { "\($0)" } ?? "" }
        set {
            if let rpeInt = Int(newValue) {
                setDetail.rpe = rpeInt
            } else {
                print("Desired RPE value \(newValue) is not an Int")
            }
        }
        //        setDetail.rpe.map { "RPE \($0)" } ?? "N/A"
    }

    var isRangeBased: Bool {
        return setDetail.suggestedRepsMin != nil || setDetail.suggestedTimeMin != nil
    }

//    var suggestedReps: String {
//        if let min = setDetail.suggestedRepsMin, let max = setDetail.suggestedRepsMax {
//            return "\(min)-\(max) reps"
//        } else if let reps = setDetail.suggestedReps {
//            return "\(reps) reps"
//        }
//        return "N/A"
//    }
//
//    var suggestedTime: String {
//        if let min = setDetail.suggestedTimeMin, let max = setDetail.suggestedTimeMax {
//            return "\(min)-\(max) sec"
//        } else if let time = setDetail.suggestedTime {
//            return "\(time) sec"
//        }
//        return "N/A"
//    }

    var reps: String {
        get { setDetail.reps.map { "\($0) reps" } ?? "N/A" }
        set {
            if let repsInt = Int(newValue) {
                setDetail.reps = repsInt
            } else {
                print("Desired reps value \(newValue) is not an Int")
            }
        }
    }

    var duration: String {
        get { setDetail.duration.map { "\($0) sec" } ?? "N/A" }
        set {
            if let duraitonInt = Int(newValue) {
                setDetail.duration = duraitonInt
            } else {
                print("Desired duration value \(newValue) is not an Int")
            }
        }
    }

    var weight: String {
        get { setDetail.weight.map { String(format: "%.1f kg", $0) } ?? "N/A" }
        set {
            if let weightDouble = Double(newValue) {
                setDetail.weight = weightDouble
            } else {
                print("Desired weight value \(newValue) is not a Double")
            }
        }
    }

    var notes: String {
        get { setDetail.notes ?? "No notes" }
        set {
            setDetail.notes = newValue
        }
    }

    init(setDetail: SetDetail) {
        self.setDetail = setDetail
//        self.id = setDetail.id
    }
}
