//
//  AddWorkoutView.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: LogsViewModel
    
    @State private var templateName: String = ""
    @State private var duration: String = ""
    @State private var exercises: [Exercise] = []
    
    @State private var showAddExerciseSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                WorkoutDetailsSection(templateName: $templateName, duration: $duration)
                
                ExerciseListSection(exercises: exercises)
                
                Button("Add Exercise") {
                    showAddExerciseSheet = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button("Save Workout", action: saveWorkout)
                    .buttonStyle(.borderedProminent)
                    .padding()
            }
            .navigationTitle("New Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(isPresented: $showAddExerciseSheet) {
                AddExerciseView(exercises: $exercises)
            }
        }
    }
    
    func saveWorkout() {
        guard let workoutDuration = Double(duration) else { return }
        
        let newWorkout = Workout(
            date: Date(),
            templateName: templateName.isEmpty ? nil : templateName,
            duration: workoutDuration * 60,
            exercises: exercises
        )
        
        viewModel.addWorkout(newWorkout)
        dismiss()
    }
}

#Preview {
    AddWorkoutView(viewModel: LogsViewModel())
}
