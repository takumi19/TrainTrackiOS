//
//  ExerciseListSection.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

//import SwiftUI
//
//struct ExerciseListSection: View {
//    var exercises: [Exercise]
//    
//    var body: some View {
//        List {
//            ForEach(exercises) { exercise in
//                VStack(alignment: .leading) {
//                    Text(exercise.name).font(.headline)
//                    Text("Type: \(exercise.movementType == .Dynamic ? "Dynamic" : "Static")")
//                    Text("Resistance: \(exercise.resistanceType == .weighted ? "Weighted" : "Bodyweight")")
//                }
//                .padding()
//                .background(Color(UIColor.systemGray6))
//                .cornerRadius(8)
//            }
//        }
//    }
//}
import SwiftUI

struct ExerciseListSection: View {
    var exercises: [Exercise]
    
    var body: some View {
        List {
            ForEach(exercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.headline)
                    Text("Type: \(exercise.movementType == .Dynamic ? "Dynamic" : "Static")")
                    Text("Resistance: \(exercise.resistanceType == .weighted ? "Weighted" : "Bodyweight")")
                    
                    ForEach(exercise.sets) { set in
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
                        .padding(.vertical, 3)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(10)
            }
        }
    }
}

