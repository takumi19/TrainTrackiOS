//
//  TrainingLogsView.swift
//  none
//
//  Created by Max Vaughan on 16.03.2025.
//

// Views/TrainingLogsView.swift
//import SwiftUI
//
//struct LogsView: View {
//    @StateObject private var viewModel = LogsViewModel()
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if viewModel.workouts.isEmpty {
//                    Text("No workouts recorded yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    List(viewModel.workouts) { workout in
//                        NavigationLink(destination: WorkoutDetailView(workout: workout, viewModel: viewModel)) {
//                            VStack(alignment: .leading) {
//                                Text(workout.templateName ?? "Custom Workout")
//                                    .font(.headline)
//                                Text("Completed on \(viewModel.formatDate(workout.date))")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                                Text("Duration: \(viewModel.formatDuration(workout.duration))")
//                                    .font(.subheadline)
//                            }
//                            .padding(.vertical, 5)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Workout Log")
//            .toolbar {
//                Button(action: addSampleWorkout) {
//                    Image(systemName: "plus")
//                }
//            }
//        }
//    }
//    
//    func addSampleWorkout() {
//        let sampleWorkout = Workout(
//            date: Date(),
//            templateName: "Full Body Strength",
//            duration: 3600,
//            exercises: [
//                Exercise(name: "Squat", movementType: .Dynamic, resistanceType: .weighted, sets: [
//                    SetDetail(repetitions: 10, weight: 100, rpe: 7),
//                    SetDetail(repetitions: 8, weight: 110, rpe: 8)
//                ]),
//                Exercise(name: "Plank", movementType: .Static, resistanceType: .bodyweight, sets: [
//                    SetDetail(duration: 60, rpe: 6)
//                ]),
//                Exercise(name: "Push-Ups", movementType: .Dynamic, resistanceType: .bodyweight, sets: [
//                    SetDetail(repetitions: 20, rpe: 5)
//                ])
//            ]
//        )
//        viewModel.addWorkout(sampleWorkout)
//    }
//}
//
//#Preview {
//    LogsView()
//}

import SwiftUI

struct LogsView: View {
    @StateObject private var viewModel = LogsViewModel()
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.workouts.isEmpty {
                    Text("No workouts recorded yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout, viewModel: viewModel)) {
                            VStack(alignment: .leading) {
                                Text(workout.templateName ?? "Custom Workout")
                                    .font(.headline)
                                Text("Completed on \(viewModel.formatDate(workout.date))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Duration: \(viewModel.formatDuration(workout.duration))")
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Workout Log")
            .toolbar {
                Button(action: {
                    showingAddWorkout = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    LogsView()
}

