import SwiftUI

struct WorkoutCardView: View {
    @State private var showDetails = false
    private var workout: Workout

    init(workout: Workout) {
        self.workout = workout
    }

    var body: some View {
        ZStack {
            // TODO: Add a triple dot button to the left
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(workout.templateName ?? workout.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Menu {
                        Button {
                        } label: {
                            Label("New Album", systemImage: "rectangle.stack.badge.plus")
                        }
                        Button {
                        } label: {
                            Label("New Folder", systemImage: "folder.badge.plus")
                        }
                        Button {
                        } label: {
                            Label("New Shared Album", systemImage: "rectangle.stack.badge.person.crop")
                        }
                    } label: {
                        Label("", systemImage: "ellipsis")
                            .foregroundStyle(Color("PrimaryColor"))
                    }
                }

                HStack {

                    Text(workout.date.formatted(
                        Date.FormatStyle()
                            .weekday(.wide)
                            .day(.defaultDigits)
                            .month(.abbreviated)
                    ))
                    Spacer()
                    if let weekNumber = testingWorkout.weekNumber {
                        Text("Week \(weekNumber)")
                    }
                }
                .font(.headline)
                .foregroundColor(.gray)

                // Duration Tonnage PRs
                HStack {
                    Image(systemName: "clock")
                    Text(String(format: "%02d", workout.duration / 60) + ":" + String(format: "%02d", workout.duration % 60))
                        .font(.subheadline)
                    Spacer()

                    Image(systemName: "dumbbell")
                    Text("\(workout.tonnage) kg")
                        .font(.subheadline)
                    Spacer()

                    if let prCount = workout.prCount {
                        Image(systemName: "trophy")
                        Text("\(prCount) PRs")
                            .font(.subheadline)
                    } else {
                        Image(systemName: "repeat")
                        Text("\(workout.exercises.count) sets")
                            .font(.subheadline)
                    }
                }

                VStack(spacing: 8) {
                    HStack {
                        Text("Exercise")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("Sets")
                            .frame(maxWidth: 60, alignment: .center)
                        Spacer()
                        Text("Best Set")
                            .frame(maxWidth: 101, alignment: .trailing)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)

                    // TODO: Make this more robust. The predefined values just feel really stiff.
                    ForEach(workout.exercises) { exercise in
                        Divider()
                        //                    Rectangle()
                        //                        .frame(width: .infinity, height: 1)
                        //                        .foregroundColor(.gray.opacity(0.3))
                        HStack {
                            Text(exercise.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Text("\(exercise.sets.count)")
                                .frame(maxWidth: 60, alignment: .center)
                            Spacer()
                            Text(exercise.bestSet)
                                .frame(maxWidth: 101, alignment: .trailing)
                        }
                        .font(.subheadline)
                        .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Color("SecondaryBg"))
            .cornerRadius(10)
//            .onTapGesture {
//                showDetails.toggle()
//            }
//            if showDetails {
//                WorkoutDetailsView(workout: workout)
//            }
        }
    }
}



// MARK: Main Training Logs Page
struct HistoryView : View {
    @ObservedObject var workouts: HistoryViewModel
    private var prevMonth: Int?
    @State private var chosenWorkout: Workout?
    @State private var showDetails: Bool

    init(workouts: HistoryViewModel) {
        self.workouts = workouts
        showDetails = false
    }

    var body : some View {
        ZStack {
            ScrollView {
                HStack {
                    Text("History")
                        .font(.largeTitle)
                        .fontWidth(.condensed)
                        .fontWeight(.bold)
                    Spacer()
                }

                // TODO: Don't call this shitty method twice
                ForEach(workouts.groupedWorkouts(), id: \.month) { section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.month)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)

                        ForEach(section.workouts) { workout in
                            WorkoutCardView(workout: workout)
                                .padding(.bottom, 16)
                                .onTapGesture {
                                    showDetails.toggle()
                                    chosenWorkout = workout
                                }
                        }
                    }
                }
                .padding(.top, 24)
            }
            //            .navigationTitle("History")
            .padding(.horizontal, 16)
            if showDetails {
                WorkoutDetailsView(isPresented: $showDetails, workout: chosenWorkout!)
            }
        }
    }
}

let testingWorkout = Workout(
    id: 1,
    date: Date(timeIntervalSince1970: 1743292800), // March 27, 2025
    templateName: "Strength Program A",
    weekNumber: 3,
    tonnage: 1500, // Total weight lifted in kilograms
    prCount: 2,
    name: "Full Body Strength",
    notes: "Felt strong today, focused on form for squats.",
    duration: 3600, // 1 hour in seconds
    exercises: [
        Exercise(
            id: 1,
            name: "Bench Press (Barbell)",
            exerciseNumber: 1,
            movementType: .Dynamic,
            resistanceType: .weighted,
            bestSet: "100 kg x 5",
            sets: [
                SetDetail(
                    id: 1,
                    setNumber: 1,
                    rpe: 7,
                    suggestedRepsMin: 5,
                    suggestedRepsMax: 8,
                    suggestedReps: 6,
                    reps: 6,
                    weight: 90.0,
                    notes: "Warm-up set"
                ),
                SetDetail(
                    id: 2,
                    setNumber: 2,
                    rpe: 8,
                    suggestedRepsMin: 5,
                    suggestedRepsMax: 8,
                    suggestedReps: 5,
                    reps: 5,
                    weight: 100.0,
                    notes: "Tough but clean"
                )
            ]
        ),
        Exercise(
            id: 2,
            name: "Pull-Ups",
            exerciseNumber: 2,
            movementType: .Dynamic,
            resistanceType: .bodyweight,
            bestSet: "12 reps",
            sets: [
                SetDetail(
                    id: 3,
                    setNumber: 1,
                    rpe: 6,
                    suggestedRepsMin: 8,
                    suggestedRepsMax: 12,
                    suggestedReps: 10,
                    reps: 10,
                    notes: "Controlled descent"
                ),
                SetDetail(
                    id: 4,
                    setNumber: 2,
                    rpe: 7,
                    suggestedRepsMin: 8,
                    suggestedRepsMax: 12,
                    suggestedReps: 10,
                    reps: 12,
                    notes: "New PR!"
                )
            ]
        ),
        Exercise(
            id: 3,
            name: "Squat Bottom Hold",
            exerciseNumber: 3,
            movementType: .Static,
            resistanceType: .weighted,
            bestSet: "50 kg x 30 sec",
            sets: [
                SetDetail(
                    id: 5,
                    setNumber: 1,
                    rpe: 6,
                    suggestedTimeMin: 20,
                    suggestedTimeMax: 30,
                    suggestedTime: 25,
                    duration: 25,
                    weight: 50.0,
                    notes: "Stable position"
                ),
                SetDetail(
                    id: 6,
                    setNumber: 2,
                    rpe: 7,
                    suggestedTimeMin: 20,
                    suggestedTimeMax: 30,
                    suggestedTime: 25,
                    duration: 30,
                    weight: 50.0,
                    notes: "Held longer than planned"
                )
            ]
        )
    ]
)

let testingWorkout1 = Workout(
    id: 1,
    date: Date(timeIntervalSince1970: 1706745600),
    templateName: "Strength Program A",
    weekNumber: 3,
    tonnage: 1500, // Total weight lifted in kilograms
    prCount: 2,
    name: "Full Body Strength",
    notes: "Felt strong today, focused on form for squats.",
    duration: 3600, // 1 hour in seconds
    exercises: [
        Exercise(
            id: 1,
            name: "Bench Press (Barbell)",
            exerciseNumber: 1,
            movementType: .Dynamic,
            resistanceType: .weighted,
            bestSet: "100 kg x 5",
            sets: [
                SetDetail(
                    id: 1,
                    setNumber: 1,
                    rpe: 7,
                    suggestedRepsMin: 5,
                    suggestedRepsMax: 8,
                    suggestedReps: 6,
                    reps: 6,
                    weight: 90.0,
                    notes: "Warm-up set"
                ),
                SetDetail(
                    id: 2,
                    setNumber: 2,
                    rpe: 8,
                    suggestedRepsMin: 5,
                    suggestedRepsMax: 8,
                    suggestedReps: 5,
                    reps: 5,
                    weight: 100.0,
                    notes: "Tough but clean"
                )
            ]
        ),
        Exercise(
            id: 2,
            name: "Pull-Ups",
            exerciseNumber: 2,
            movementType: .Dynamic,
            resistanceType: .bodyweight,
            bestSet: "12 reps",
            sets: [
                SetDetail(
                    id: 3,
                    setNumber: 1,
                    rpe: 6,
                    suggestedRepsMin: 8,
                    suggestedRepsMax: 12,
                    suggestedReps: 10,
                    reps: 10,
                    notes: "Controlled descent"
                ),
                SetDetail(
                    id: 4,
                    setNumber: 2,
                    rpe: 7,
                    suggestedRepsMin: 8,
                    suggestedRepsMax: 12,
                    suggestedReps: 10,
                    reps: 12,
                    notes: "New PR!"
                )
            ]
        ),
        Exercise(
            id: 3,
            name: "Squat Bottom Hold",
            exerciseNumber: 3,
            movementType: .Static,
            resistanceType: .weighted,
            bestSet: "50 kg x 30 sec",
            sets: [
                SetDetail(
                    id: 5,
                    setNumber: 1,
                    rpe: 6,
                    suggestedTimeMin: 20,
                    suggestedTimeMax: 30,
                    suggestedTime: 25,
                    duration: 25,
                    weight: 50.0,
                    notes: "Stable position"
                ),
                SetDetail(
                    id: 6,
                    setNumber: 2,
                    rpe: 7,
                    suggestedTimeMin: 20,
                    suggestedTimeMax: 30,
                    suggestedTime: 25,
                    duration: 30,
                    weight: 50.0,
                    notes: "Held longer than planned"
                )
            ]
        )
    ]
)

#Preview {
    HistoryView(workouts: HistoryViewModel(workouts: [testingWorkout, testingWorkout, testingWorkout1, testingWorkout1, testingWorkout]))
        .background(Color("PrimaryBg"))
}
