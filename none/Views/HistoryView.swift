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
                            Label("Edit", systemImage: "folder.badge.plus")
                        }
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
                    Text(String(format: "%02d", (workout.duration ?? 2914) / 60) + ":" + String(format: "%02d", (workout.duration ?? 2914) % 60))
                        .font(.subheadline)
                    Spacer()

                    Image(systemName: "dumbbell")
                    Text("\(workout.tonnage) kg")
                        .font(.subheadline)
                    Spacer()

                    if workout.prCount != 0 {
                        Image(systemName: "trophy")
                        Text("\(workout.prCount) PRs")
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
    @StateObject var workouts: HistoryViewModel = HistoryViewModel()
    private var prevMonth: Int?
    @State private var chosenWorkout: Workout = Workout()
    @State private var showDetails: Bool = false
    @State private var showEditing: Bool = false

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 32, weight: .bold, width: .condensed)]
    }

//    init(workouts: HistoryViewModel) {
//        self.workouts = workouts
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 32, weight: .bold, width: .condensed)]
//    }

    var body : some View {
//        NavigationStack {
            ZStack {
                ScrollView {
                    HStack {
                        Text("History")
                            .font(.largeTitle)
                            .fontWidth(.condensed)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            chosenWorkout = Workout()
                            self.showEditing.toggle()
                        }) {
                            Image(systemName: "plus")
                                .foregroundStyle(Color("PrimaryColor"))
                                .font(.system(size: 20, weight: .bold)) // Increase size and weight
                                .symbolRenderingMode(.monochrome) // Ensure consistent styling
                        }
                    }

                    ForEach(workouts.groupedWorkouts(), id: \.month) { section in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(section.month)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .fontWeight(.semibold)
                                .padding(.bottom, 8)

                            ForEach(Array(section.workouts.enumerated()), id: \.offset) { index, workout in
//                                NavigationLink(value: workout) {
                                    WorkoutCardView(workout: workout)
                                        .padding(.bottom, 16)
                                        .onTapGesture {
                                            showDetails.toggle()
                                            chosenWorkout = workout
                                            workouts.chosenWorkoutIndex = index
                                        }
//                                }
//                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.top, 24)
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 16)
                if showDetails {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
//                            showDetails.toggle()
                            withAnimation { showDetails = false }
                        }
                        .transition(.opacity)
                        .zIndex(1)
                    WorkoutDetailsView(isPresented: $showDetails, workout: chosenWorkout, showEditing: $showEditing)
                        .transition(.popUp)
                        .zIndex(2)
                }

                if showEditing {
                    EditWorkoutView(workout: chosenWorkout, isPresented: $showEditing, onSave: workouts.onSave)
                }
            }
            .background(Color("PrimaryBg"))
            .task {
                workouts.fetch()
            }
            .animation(.spring(response: 0.2, dampingFraction: 0.8),
                       value: showDetails)
//            .navigationTitle("History")
//            .navigationBarTitleDisplayMode(.large)
//            .navigationDestination(for: Workout.self) { workout in
//                WorkoutDetailsView(isPresented: $showDetails, workout: workout)
//            }
//        }
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
            movementType: .Dynamic,
            resistanceType: .weighted,
            bestSet: "100 kg x 5",
            sets: [
                SetDetail(
                    id: 1,
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
            movementType: .Dynamic,
            resistanceType: .bodyweight,
            bestSet: "12 reps",
            sets: [
                SetDetail(
                    id: 3,
                    rpe: 6,
                    suggestedRepsMin: 8,
                    suggestedRepsMax: 12,
                    suggestedReps: 10,
                    reps: 10,
                    notes: "Controlled descent"
                ),
                SetDetail(
                    id: 4,
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
            movementType: .Static,
            resistanceType: .weighted,
            bestSet: "50 kg x 30 sec",
            sets: [
                SetDetail(
                    id: 5,
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
            movementType: .Dynamic,
            resistanceType: .weighted,
            bestSet: "100 kg x 5",
            sets: [
                SetDetail(
                    id: 1,
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
            movementType: .Dynamic,
            resistanceType: .bodyweight,
            bestSet: "12 reps",
            sets: [
                SetDetail(
                    id: 3,
                    rpe: 6,
                    suggestedRepsMin: 8,
                    suggestedRepsMax: 12,
                    suggestedReps: 10,
                    reps: 10,
                    notes: "Controlled descent"
                ),
                SetDetail(
                    id: 4,
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
            movementType: .Static,
            resistanceType: .weighted,
            bestSet: "50 kg x 30 sec",
            sets: [
                SetDetail(
                    id: 5,
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

extension AnyTransition {
    static var popUp: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.8, anchor: .center)
                       .combined(with: .opacity),
            removal:   .opacity
        )
    }
}

#Preview {
    HistoryView()
    //    HistoryView(workouts: HistoryViewModel(workouts: [testingWorkout, testingWorkout, testingWorkout1, testingWorkout1, testingWorkout]))
//        .background(Color("PrimaryBg"))
}
