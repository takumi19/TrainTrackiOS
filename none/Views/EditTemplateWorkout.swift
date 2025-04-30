//
//  EditTemplateWorkout.swift
//  none
//
//  Created by Max Vaughan on 21.04.2025.
//

import SwiftUI

struct EditTemplateWorkoutView: View {
    @State var workout: Workout
    @State var showSearchExercises: Bool = false
    @State var str: String = "1"
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {

                // MARK: Top Bar
                HStack {
                    Button(action: {
                        dismiss()
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
                    if let notes = workout.notes {
                        Text(notes)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.top, 4)
                    }
                }
                .padding(.top, 12)
                ScrollView {
                    ForEach(workout.exercises) { exercise in
                        Divider()
                            .padding(.top, 24)
                        TemplateExerciseGrid(exercise: exercise)
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
            .padding()
            .background(.secondaryBg)
            if self.showSearchExercises {
                ExerciseSearch(isPresented: $showSearchExercises, workout: $workout)
            }
        }
        .toolbarVisibility(.hidden)

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

struct TemplateExerciseGrid: View {
    @State var exercise: Exercise
    @State var str: String = ""
    @State var rangeChosen: Bool = true

    var body: some View {
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

                if exercise.movementType == .Dynamic {
                    if rangeChosen {
                        Text("Rep Range")
                            .gridColumnAlignment(.center)
                    } else {
                        Text("Reps")
                            .gridColumnAlignment(.center)
                    }
                } else if exercise.movementType == .Static {
                    if rangeChosen {
                        Text("Time Range")
                            .gridColumnAlignment(.center)
                    } else {
                        Text("Time")
                            .gridColumnAlignment(.center)
                    }
                }

                Text("RPE")
                    .gridColumnAlignment(.center)
            }
            .font(.subheadline)
            .foregroundStyle(.gray)

            Divider()

            // MARK: Set Table
            ForEach(Array(exercise.sets.enumerated()), id: \.offset) { index, set in
                GridRow {
                    Text("\(index + 1)")
                        .foregroundStyle(.gray)

                    // TODO: Add support for target range
                    HStack {
                        TextField("", text: $str)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 20, maxHeight: 4, alignment: .center)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("PrimaryColor"), lineWidth: 2)
                                )
                        if rangeChosen {
                            Text("-")
                                .foregroundStyle(.gray)
                            TextField("", text: $str)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 20, maxHeight: 4, alignment: .center)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("PrimaryColor"), lineWidth: 2)
                                )
                        }
                    }

                    Text("\(set.rpe ?? 0)")
                }
            }
        }

        // MARK: Add Set Button
        Button {
            print("Add something")
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
        .frame(width: 50, height: 30)
    }
}

#Preview {
    // Wrapper view to provide the binding
    struct PreviewWrapper: View {
        @State var isPresented: Bool = true

        var body: some View {
            EditTemplateWorkoutView(workout: testingWorkout)
        }
    }

    return PreviewWrapper()
}
