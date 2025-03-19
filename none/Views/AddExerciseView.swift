//
//  AddExerciseView.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var exercises: [Exercise]
    
    @State private var exerciseName: String = ""
    @State private var movementType: MovementType = .Dynamic
    @State private var resistanceType: ResistanceType = .bodyweight
    @State private var sets: [SetDetail] = []
    
    @State private var reps: String = ""
    @State private var duration: String = ""
    @State private var weight: String = ""
    @State private var rpe: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Exercise Details")) {
                        TextField("Exercise Name", text: $exerciseName)
                        
                        Picker("Movement Type", selection: $movementType) {
                            Text("Dynamic").tag(MovementType.Dynamic)
                            Text("Static").tag(MovementType.Static)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Picker("Resistance Type", selection: $resistanceType) {
                            Text("Weighted").tag(ResistanceType.weighted)
                            Text("Bodyweight").tag(ResistanceType.bodyweight)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Add Set")) {
                        if movementType == .Dynamic {
                            TextField("Reps", text: $reps)
                                .keyboardType(.numberPad)
                        }
                        if movementType == .Static {
                            TextField("Time (seconds)", text: $duration)
                                .keyboardType(.numberPad)
                        }
                        if resistanceType == .weighted {
                            TextField("Weight (kg)", text: $weight)
                                .keyboardType(.decimalPad)
                        }
                        TextField("RPE (optional)", text: $rpe)
                            .keyboardType(.numberPad)
                        
                        Button("Add Set", action: addSet)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    
                    Section(header: Text("Sets")) {
                        if sets.isEmpty {
                            Text("No sets added yet.")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(sets) { set in
                                VStack(alignment: .leading) {
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
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                
                Button("Save Exercise") {
                    saveExercise()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    func addSet() {
        let newSet = SetDetail(
            repetitions: Int(reps),
            duration: Double(duration),
            weight: Double(weight),
            rpe: Int(rpe)
        )
        sets.append(newSet)
        
        // Reset input fields
        reps = ""
        duration = ""
        weight = ""
        rpe = ""
    }
    
    func saveExercise() {
        guard !exerciseName.isEmpty else { return }
        
        let newExercise = Exercise(
            name: exerciseName,
            movementType: movementType,
            resistanceType: resistanceType,
            sets: sets
        )
        
        exercises.append(newExercise)
        dismiss()
    }
}

#Preview {
    AddExerciseView(exercises: .constant([]))
}
