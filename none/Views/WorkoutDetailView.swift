//
//  WorkoutDetailView.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

import SwiftUI

struct WorkoutDetailView: View {
    var workout: Workout
    @ObservedObject var viewModel: LogsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HeaderView(workout: workout, viewModel: viewModel)
                ExerciseListView(exercises: workout.exercises)
            }
            .padding()
        }
        .navigationTitle("Workout Details")
    }
}

// MARK: - Header View
struct HeaderView: View {
    var workout: Workout
    var viewModel: LogsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(workout.templateName ?? "Custom Workout")
                .font(.title)
                .bold()
            
            Text("Completed on \(viewModel.formatDate(workout.date))")
                .foregroundColor(.gray)
            
            Text("Duration: \(viewModel.formatDuration(workout.duration))")
                .font(.headline)
                .padding(.top, 5)
        }
    }
}

// MARK: - Exercise List View
struct ExerciseListView: View {
    var exercises: [Exercise]
    
    var body: some View {
        ForEach(exercises) { exercise in
            SectionView(exercise: exercise)
        }
    }
}

// MARK: - Exercise Section View
struct SectionView: View {
    var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(exercise.name)
                .font(.headline)
            
            Text("Type: \(exercise.movementType == .Dynamic ? "Dynamic" : "Static")")
            Text("Resistance: \(exercise.resistanceType == .weighted ? "Weighted" : "Bodyweight")")
            
            ForEach(exercise.sets) { set in
                SetDetailView(set: set)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

// MARK: - Set Detail View
struct SetDetailView: View {
    var set: SetDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            if let reps = set.repetitions {
                Text("Reps: \(reps)")
            }
            if let duration = set.duration {
                Text("Time: \(Int(duration)) sec")
            }
            if let weight = set.weight {
                Text("Weight: \(weight) kg")
            }
            if let rpe = set.rpe {
                Text("RPE: \(rpe)")
            }
        }
        .padding(.vertical, 3)
    }
}

#Preview {
    WorkoutDetailView(
        workout: Workout(
            date: Date(),
            templateName: "Full Body Strength",
            duration: 3600,
            exercises: [
                Exercise(name: "Squat", movementType: .Dynamic, resistanceType: .weighted, sets: [
                    SetDetail(repetitions: 10, weight: 100, rpe: 7),
                    SetDetail(repetitions: 8, weight: 110, rpe: 8)
                ]),
                Exercise(name: "Plank", movementType: .Static, resistanceType: .bodyweight, sets: [
                    SetDetail(duration: 60, rpe: 6)
                ]),
                Exercise(name: "Push-Ups", movementType: .Dynamic, resistanceType: .bodyweight, sets: [
                    SetDetail(repetitions: 20, rpe: 5)
                ])
            ]
        ),
        viewModel: LogsViewModel()
    )
}
