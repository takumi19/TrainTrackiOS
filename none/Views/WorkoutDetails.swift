//
//  DetailedWorkoutView.swift
//  none
//
//  Created by Max Vaughan on 10.04.2025.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @Binding var isPresented: Bool
    var workout: Workout
    @Binding var showEditing: Bool

//    init(@Binding isPresented: Bool, workout: Workout) {
//        self.isPresented = isPresented
//        self.workout = workout
//    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.toggle()
                }
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.square.fill")
                            .symbolRenderingMode(.palette)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color("PrimaryColor"), Color.black.opacity(0.3))
                    }
                    .frame(width: 32, height: 32) // Define frame size
                    Spacer()
                    Text(workout.templateName ?? workout.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        isPresented = false
                        showEditing = true
//                        EditWorkoutView(workout: workout)
//                        print("Editing")
                    }) {
                        Text("Edit")
                            .foregroundColor(Color("PrimaryColor"))
                            .font(.title3)
                    }
                }

                // Workout Date
                Text(workout.date.formatted(
                    .dateTime
                        .hour(.defaultDigits(amPM: .omitted))
                        .minute()
                        .weekday(.abbreviated)
                        .day()
                        .month(.abbreviated)
                ))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 12)

                // Notes
                if let notes = workout.notes {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                }

                // Exercise Table
                ScrollView {
                    ForEach(workout.exercises) { exercise in
                        Text(exercise.name)
                            .font(.headline)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Grid(alignment: .leading) {
                            GridRow {
                                Text("Set")
                                    .gridColumnAlignment(.center)
                                if workout.templateName != nil {
                                    Text("Target")
                                        .gridColumnAlignment(.center)
                                }
                                if exercise.resistanceType == .weighted {
                                    Text("kg")
                                        .gridColumnAlignment(.center)
                                }
                                if exercise.movementType == .Dynamic {
                                    Text("Reps")
                                        .gridColumnAlignment(.center)
                                } else if exercise.movementType == .Static {
                                    Text("Time")
                                        .gridColumnAlignment(.center)
                                }
                                Text("RPE")
                                    .gridColumnAlignment(.center)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            Divider()

                            // Sets
                            ForEach(Array(exercise.sets.enumerated()), id: \.offset) { index, set in
                                GridRow {
                                    Text("\(index + 1)")
                                        .foregroundStyle(.gray)

                                    // TODO: Add support for target range
                                    if let target = set.suggestedReps {
                                        Text("\(target) reps")
                                    } else {
                                        Text("-")
                                            .foregroundStyle(.gray)
                                    }
                                    if exercise.resistanceType == .weighted {
                                        Text("\(set.weight ?? 0, specifier: "%.0f")")
                                    }
                                    if exercise.movementType == .Dynamic {
                                        Text("\(set.reps!)")
                                            .gridColumnAlignment(.center)
                                    } else if exercise.movementType == .Static {
                                        Text("\(set.duration!)")
                                            .gridColumnAlignment(.center)
                                    }
                                    Text("\(set.rpe ?? 0)")
                                }
                                Divider()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .frame(width: 350, height: 570) // Adjusted size to fit content
            .shadow(radius: 10)
            .animation(.easeInOut(duration: 0.5), value: isPresented)
            .padding()
            .background(Color("SecondaryBg"))
            .clipShape(.rect(cornerRadius: 10))
        }
    }
}

#Preview {
    Text("Hi")
    //    var isPresented: Bool = true
//    WorkoutDetailsView(isPresented: $isPresented, workout: testingWorkout)
}
