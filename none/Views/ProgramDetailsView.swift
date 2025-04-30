//
//  ProgramWeekCard.swift
//  none
//
//  Created by Max Vaughan on 21.04.2025.
//

import SwiftUI

struct ProgramModel: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var weekCount: Int
    var weeks: [ProgramWeek]
}

struct ProgramWeek: Identifiable {
    var id = UUID()
    var weekNumber: Int
    var description: String
    var workouts: [Workout]
}

struct ProgramWorkoutCardView: View {
    var workout: Workout

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(workout.name)
                    .padding(.bottom)
                    .fontWeight(.semibold)
                    .font(.title3)
//                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Menu {
                    Button {
                    } label: {
                        Label("Delete", systemImage: "rectangle.stack.badge.person.crop")
                    }
                } label: {
                    Label("", systemImage: "ellipsis")
                        .foregroundStyle(Color("PrimaryColor"))
                        .font(.system(size: 18, weight: .bold))
                        .symbolRenderingMode(.monochrome)
                        .imageScale(.large)
                }
            }

            Spacer().frame(maxHeight: 30)
            ForEach(Array(workout.exercises.enumerated()), id: \.offset) { index, exercise in
                HStack(alignment: .top) {
                    Text("\(index + 1)")
                        .foregroundStyle(.secondaryAccent)
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .fontWeight(.semibold)
                            .padding(.bottom, 4)
                        HStack {
                            Text("\(exercise.sets.count) Sets")
                            Spacer()
                            // TODO: Plug viewmodel's method here which would handle the logic
                            Text("4-8 Reps")
                            Spacer()
                            Text("RPE 8")
                            Spacer()
                        }
                        .foregroundStyle(Color("SecondaryLabel"))
                        .fontWeight(.semibold)
                    }
                    .padding(.bottom, 8)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .padding(.vertical, 8)
            }
        }
        .padding()
        .background(Color("SecondaryBg"))
        .cornerRadius(10)
    }
}

struct ProgramWeeksView: View {
    var program: ProgramModel
    @Environment(\.dismiss) var dismiss

    init(program: ProgramModel) {
        self.program = program
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(Array(program.weeks.enumerated()), id: \.element.id) { index, week in
                    Section(header: Text("Week \(index + 1)").font(.title).fontWeight(.bold)) {
                        ForEach(week.workouts) { workout in
                            NavigationLink(destination: EditTemplateWorkoutView(workout: workout)) {
                                ProgramWorkoutCardView(workout: workout)
                            }
                            .buttonStyle(.plain)
                        }
                        Button {
                            // Add logic to append a new workout
                            print("Add Workout")
                        } label: {
                            Text("Add Workout")
                                .font(.headline)
                                .foregroundStyle(Color("PrimaryColor"))
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color("PrimaryColor").opacity(0.4))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color("PrimaryBg"))
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar() {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.primaryLabel)
                })
            }
            ToolbarItem(placement: .principal) {
                Text("Edit Program")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    print("Hi")
                }
//                .padding(8)
//                .background(.black.opacity(0.3))
//                .clipShape(.buttonBorder)
                .foregroundStyle(Color.secondaryLabel)
                .fontWeight(.semibold)
            }
        }
    }
}

func initWeeks() -> [ProgramWeek] {
    var weeks: [ProgramWeek] = []
    for index in 1..<3 {
        var tw = testingWorkout
        tw.id += 1
        var tw1 = tw
        tw.id += 1
        var tw2 = tw1
        tw.id += 1
        var tw3 = tw2
        tw.id += 1
        weeks.append(.init(weekNumber: index, description: "none", workouts: [tw, tw1, tw2, tw3]))
    }
    return weeks
}

#Preview {
//    ProgramWorkoutCardView(workout: testingWorkout)
    var program: ProgramModel = .init(name: "Jim Wendler's 5/3/1", description: "6 Days a week program with a 3 day microcycle: Chest and Back, Arms and Shoulders, Legs.", weekCount: 3, weeks: initWeeks())
    NavigationStack {
        NavigationLink(destination: ProgramWeeksView(program: program)) {
            Text("Hello World")
        }
    }

}
