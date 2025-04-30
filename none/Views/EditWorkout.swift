//
//  EditWorkout.swift
//  none
//
//  Created by Max Vaughan on 12.04.2025.
//
import SwiftUI

extension Exercise {
    mutating func addSet() {
        if !self.sets.isEmpty {
            self.sets.append(self.sets.last!)
            return
        }
        var set: SetDetail = SetDetail()
        if self.resistanceType == .weighted {
            set.weight = 10
        }
        if self.movementType == .Static {
            set.duration = 30
        } else {
            set.reps = 10
        }
        self.sets.append(set)
    }
}

struct EditWorkoutView: View {
    @State var workout: Workout
    @Binding var isPresented: Bool
    let onSave: (Workout) -> Void
    @State var showSearchExercises: Bool = false
    @State var exercises: [Exercise] = []
    //    @ObservedObject var vm: WorkoutViewModel = WorkoutViewModel(workout: workout)

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {

                // MARK: Top Bar
                HStack {
                    Button(action: {
                        isPresented = false
                        print("Pressed")
                    }) {
                        Image(systemName: "xmark.square.fill")
                            .symbolRenderingMode(.palette)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color("PrimaryColor"), Color.black.opacity(0.3))
                    }
                    .frame(width: 35, height: 35) // Define frame size
                    Spacer()
                    Text("Edit Workout")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button("Save") {
                        print("Hi")
                        self.onSave(workout)
                        self.isPresented = false
                    }
                    .padding(8)
                    .background(.black.opacity(0.3))
                    .clipShape(.buttonBorder)
                    .foregroundStyle(Color("PrimaryColor"))
                    .fontWeight(.semibold)
                }

                // MARK: Header - Name, Notes, Date
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(workout.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            print("Editing the name of the workout")
                        }) {
                            Image(systemName: "pencil")
                                .foregroundStyle(.white)
                        }
                    }
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
                    TextField("Notes", text: Binding(
                        get: { workout.notes ?? "" },
                        set: { workout.notes = $0 }
                    ))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                }
                .padding(.top, 12)
                ScrollView {
                    ForEach($workout.exercises) { $exercise in
                        Divider()
                            .padding(.top, 24)
                        HStack {
                            Text(exercise.name)
                                .font(.headline)
                                .foregroundStyle(Color("PrimaryColor"))
                            Spacer()

                            moreButton
                        }
                        .padding(.bottom, 12)
                        Grid {
                            GridRow {
                                Text("Set")
                                    .gridColumnAlignment(.center)
//                                if workout.templateName != nil {
                                    Text("Target")
                                        .gridColumnAlignment(.center)
//                                }
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
                            ForEach(Array($exercise.sets.enumerated()), id: \.offset) { index, $set in
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
//                                        Text("\(set.weight ?? 0, specifier: "%.0f")")
                                        TextField("", text: Binding(
                                            get: {
                                                if let weight = set.weight {
                                                    return String(weight)
                                                }
                                                return ""
                                            },
                                            set: { newValue in
                                                if let weightValue = Double(newValue) {
                                                    set.weight = weightValue
                                                }
                                            }
                                        ))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 50, maxHeight: 40, alignment: .center)
//                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("PrimaryColor"), lineWidth: 2)
                                        )
//                                        TextField("", text: $weight)
//                                            .multilineTextAlignment(.center)
//                                            .frame(maxWidth: 20, maxHeight: 4, alignment: .center)
//                                            .padding()
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 10)
//                                                    .stroke(Color("PrimaryColor"), lineWidth: 2)
//                                            )
                                    }
                                    if exercise.movementType == .Dynamic {
                                        TextField("", text: Binding( // $str
                                            get: {
                                                if let reps = set.reps {
                                                    return String(reps)
                                                }
                                                return ""
                                            },
                                            set: { newValue in
                                                if let reps = Int(newValue) {
                                                    set.reps = reps
                                                } else {
                                                    print("\(newValue) could not be converted to int")
                                                }
                                            }
                                        ))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 20, maxHeight: 4, alignment: .center)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("PrimaryColor"), lineWidth: 2)
                                        )
                                    } else if exercise.movementType == .Static {
                                        Text("\(set.duration!)")
                                            .gridColumnAlignment(.center)
                                            .frame(maxWidth: 25, maxHeight: 4, alignment: .center)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("PrimaryColor"), lineWidth: 2)
                                            )
                                    }
//                                    Text("\(set.rpe ?? 0)")
                                    TextField("6", text: Binding( // $rpe
                                        get: { String(set.rpe ?? 0) },
                                        set: { newValue in
                                            if let rpe = Int(newValue) {
                                                set.rpe = rpe
                                            } else {
                                                print("\(newValue) could not be converted to int")
                                            }
                                        }
                                    ))
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 20, maxHeight: 4, alignment: .center)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("PrimaryColor"), lineWidth: 2)
                                    )
                                }
                            }
                        }
                        .padding(.bottom)
                        Button {
                            print("Add something")
                            exercise.addSet()
                        } label: {
                            Label("Add Set", systemImage: "plus")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(4)
                        .background(.black.opacity(0.3))
                        .clipShape(.buttonBorder)
                        .foregroundStyle(Color("PrimaryLabel"))
                        .fontWeight(.semibold)
                    }

                    // MARK: Add Exercise Button
                    Button {
                        print("Add something")
                        self.showSearchExercises.toggle()
                    } label: {
                        Text("Add Exercise")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 32)
                    .padding(12)
                    .background(.green.opacity(0.3))
                    .clipShape(.buttonBorder)
                    .foregroundStyle(Color("PrimaryColor"))
                    .fontWeight(.semibold)
                    .padding(.vertical)

                    // MARK: Delete Exercise Button
                    Button {
                        print("Delete Workout")
                    } label: {
                        Text("Delete Workout")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(12)
                    .background(.cancel.opacity(0.3))
                    .clipShape(.buttonBorder)
                    .foregroundStyle(.cancel)
                    .fontWeight(.semibold)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal)
            .background(.secondaryBg)
            if self.showSearchExercises {
                ExerciseSearch(isPresented: $showSearchExercises, workout: $workout)
            }
        }
        .toolbar(.hidden, for: .tabBar)
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
        .frame(width: 40, height: 30)
    }
}

#Preview {
    EditWorkoutView(workout: testingWorkout, isPresented: .constant(true), onSave: { _ in })
}
