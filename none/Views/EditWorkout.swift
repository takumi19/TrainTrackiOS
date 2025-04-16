//
//  EditWorkout.swift
//  none
//
//  Created by Max Vaughan on 12.04.2025.
//
import SwiftUI

struct EditWorkoutView: View {
    //    @Binding var isPresented: Bool
    var workout: Workout
    @State var str: String = "1"

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // MARK: Top Bar
            HStack {
                Button(action: {
                    //  isPresented = false
                    print("Pressed")
                }) {
                    Image(systemName: "xmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color("PrimaryColor"), Color.black.opacity(0.3))
//                        .foregroundColor(Color("PrimaryColor"))
//                        .font(.title2)
                }
                .frame(width: 35, height: 35) // Define frame size
//                .padding(6)
//                .background(.black.opacity(0.4))
//                .clipShape(.buttonBorder)
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
                .background(.black.opacity(0.4))
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
                        //                        .frame(minWidth: 24, minHeight: 24)
                        //                        .scaledToFill()
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
                //                .padding(.top, 12)
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
                        ForEach(exercise.sets) { set in
                            GridRow {
                                Text("\(set.setNumber)")
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
                                    //                                TextField("\(set.weight ?? 0, specifier: "%.0f")", text: $set.weight)
                                }
                                if exercise.movementType == .Dynamic {
                                    //                                    TextField("", text: $str)
                                    //                                        .frame(maxWidth: 32, maxHeight: .infinity)
                                    //                                        .multilineTextAlignment(.center)
                                    //                                        .overlay(
                                    //                                            RoundedRectangle(cornerSize: 10)
                                    //                                                .stroke(Color.green, lineWidth: 2)
                                    //                                        )
                                    TextField("", text: $str)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 20, maxHeight: 4, alignment: .center)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("PrimaryColor"), lineWidth: 2)
                                        )
                                    // Text("\(set.reps!)")
                                    //      .gridColumnAlignment(.center)
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
                                Text("\(set.rpe ?? 0)")
                            }
                        }
                    }
                    .padding(.bottom)
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

                // MARK: Add Exercise Button
                Button {
                    print("Add something")
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
        }
        .padding()
        .background(.secondaryBg)
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
    EditWorkoutView(/*isPresented: true,*/ workout: testingWorkout)
}
