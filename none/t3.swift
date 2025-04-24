//
//  EditWorkout.swift
//  none
//
//  Created by Max Vaughan on 12.04.2025.
//
import SwiftUI

struct t3: View {
    @Binding var workout: Workout
    @Binding var isPresented: Bool
    @State var showSearchExercises: Bool = false
    @State var str: String = "1"
//    @ObservedObject var vm: WorkoutViewModel = WorkoutViewModel(workout: workout)

    var body: some View {
        VStack(alignment: .leading) {
            ForEach($workout.exercises) { $exercise in
//                Text(exercise.name)
                TextField("Name", text: $exercise.name)
                    .background(Color.gray.opacity(0.1))
                ForEach(Array($exercise.sets.enumerated()), id: \.offset) { index, $set in
                    Text("\(set.reps ?? 0) x \(set.weight ?? 1.0)")
                    TextField("Reps", text: Binding(
                        get: {
                            if let reps = set.reps {
                                return String(reps)
                            } else {
                                return ""
                            }
                        },
                        set: { newValue in
                            if let repsInt = Int(newValue) {
                                set.reps = repsInt
                            } else {
                                print("NOPE")
                            }
                        }
                    ))
                    .background(Color.gray.opacity(0.1))
                }
            }
        }
    }

    private var moreButton: some View {
        Menu {
            Button("Option 1", action: { print("Option 1 tapped") })
            Button("Option 2", action: { print("Option 2 tapped") })
        } label: {
            Image(systemName: "ellipsis.rectangle.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color("PrimaryColor"), Color.black.opacity(0.3))
        }
        .frame(width: 50, height: 30) // Define frame size
    }
}

#Preview {
    // Wrapper view to provide the binding
    struct PreviewWrapper: View {
        @State var isPresented: Bool = true
        @State var workout = testingWorkout

        var body: some View {
            t3(workout: $workout, isPresented: $isPresented)
        }
    }

    return PreviewWrapper()
}
