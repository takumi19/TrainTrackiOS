//
//  ExerciseSearch.swift
//  none
//
//  Created by Max Vaughan on 14.04.2025.
//
import SwiftUI

extension Workout {
    mutating func addExercise(_ exercise: Exercise) {
        self.exercises.append(exercise)
    }
}

struct ExerciseSearch: View {
    @Binding var isPresented: Bool
    @State var isPicked: Bool = false
    @State private var searchTerm: String = ""
    @State var exercises: [ExerciseInfo] = []
    @Binding var workout: Workout
    @State private var selection = Set<Int>()
    @StateObject var exercisevm: ExerciseInfoViewModel = ExerciseInfoViewModel()

    @State var isLoading: Bool = false

    var filteredExercises: [ExerciseInfo] {
        guard !searchTerm.isEmpty else { return exercisevm.exercises }
        return exercisevm.exercises.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.toggle()
                }
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Page Header
                HStack {
                    // TODO: Factor the close button out into a separate component
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
                    .frame(width: 32, height: 32)
                    Button("New") {
                        print("New Execise Being Created")
                    }
                    .foregroundStyle(Color("PrimaryColor"))
                    .frame(maxWidth: 36)
//                    .font(.caption)
                    .fontWeight(.semibold)
                    Spacer()

                    // hstack: plain text button, divider, plain text button
                    // frame with padding and black fill, rounded corners
                    HStack {
                        Button("Superset") {
                            print("superset")
                        }
                        .foregroundStyle(selection.count < 2 ? .gray : Color("PrimaryColor"))
                        Rectangle()
                            .frame(width: 2, height: 20)
                            .foregroundStyle(.gray)
                        Button("Add") {
                            for id in selection {
                                print("ID: \(id)")
                                if let idx = exercisevm.exercises.firstIndex(where: { $0.id == id }) {
                                    workout.addExercise(Exercise(info: exercisevm.exercises[idx]))
                                }
//                                if self.exercisevm.exercises.indices.contains(id) {
//                                    self.workout.addExercise(Exercise(info: self.exercisevm.exercises[id]))
//                                }
                            }
                            self.isPresented.toggle()
                            print("added")
                        }
                        .foregroundStyle(selection.isEmpty ? .gray : Color("PrimaryColor"))
                    }
                    .padding(.horizontal)
                    .frame(height: 32) // Define frame size
                    .background(.black.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .fontWeight(.semibold)
                } // Page Header
                .padding()
                Spacer()

                // MARK: Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondaryLabel)
                    TextField("Search bar", text: $searchTerm) {
                    }
                }
                .padding()
                .lineLimit(1)
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("PrimaryColor"), lineWidth: 2)
                )
                .padding(.horizontal)

                // MARK: Exercise List
                // TODO: Make it sorted by alphabet
                List/*(selection: $selection)*/ {
                    if searchTerm.isEmpty {
                        ForEach(Array(exercisevm.groupedExercises.keys), id: \.self) { key in
                            Section(header: Text(key)) {
                                ForEach(exercisevm.groupedExercises[key]!/*, id: \.id*/) { e in
                                    ExerciseRow(exercise: e, selected: selection.contains(e.id))
                                        .onTapGesture {
                                            toggleSelection(e.id)
                                        }
                                }
                            }
                        }
                    } else {
                        ForEach(filteredExercises, id: \.id) { e in
                            ExerciseRow(exercise: e, selected: selection.contains(e.id))
                                .onTapGesture {
                                    toggleSelection(e.id)
                                }
                        }
                    }
                }
                .task {
                    exercisevm.fetchExercises()
                } // Exercise List
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .frame(width: 350, height: 650) // Adjusted size to fit content
            .shadow(radius: 10)
            .animation(.easeInOut(duration: 0.5), value: isPresented)
            .background(Color("SecondaryBg"))
            .clipShape(.rect(cornerRadius: 10))
        }
    }

    private func toggleSelection(_ id: Int) {
        if selection.contains(id) {
            selection.remove(id)
        } else {
            selection.insert(id)
        }
    }
}

struct ExerciseRow: View {
    @State var exercise: ExerciseInfo
    var selected: Bool

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://vectorified.com/image/bench-press-vector-25.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 50, maxHeight: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: 50, maxHeight: 50)
            }
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(exercise.muscleGroups.joined(separator: ", "))
                    .foregroundStyle(.secondaryLabel)
            }
            .padding(.horizontal, 8)
            Spacer()
            if selected {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color("PrimaryColor"))
                    .frame(maxWidth: 24, maxHeight: 24)
            }
        }
//        .background(selected ? Color("PrimaryColor").opacity(0.3) : Color.clear)
        .listRowSeparator(selected ? Visibility.hidden : Visibility.visible)
        .listRowBackground(selected ? Color("PrimaryColor").opacity(0.3) : Color.clear)
        .listRowSpacing(16)
    }

}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
//        ExerciseSearch()
    }
}
