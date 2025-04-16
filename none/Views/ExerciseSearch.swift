//
//  ExerciseSearch.swift
//  none
//
//  Created by Max Vaughan on 14.04.2025.
//
import SwiftUI

struct ExerciseSearch: View {
    @State var isPresented: Bool = true
    @State var isPicked: Bool = false
    @State private var searchTerm: String = ""
    @State var exercises: [ExerciseInfo] = []
//    @State private var selection = Set<ExerciseInfo>()
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
                        //  isPresented = false
                        print("Pressed")
                    }) {
                        Image(systemName: "xmark.square.fill")
                            .symbolRenderingMode(.palette)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color("PrimaryColor"), Color.black.opacity(0.3))
                    }
                    .frame(width: 35, height: 35) // Define frame size
                    Button("New") {
                        print("New Execise Being Created")
                    }
                    .foregroundStyle(Color("PrimaryColor"))
                    .frame(minWidth: 60)
                    .fontWeight(.semibold)
                    Spacer()

                    // hstack: plain text button, divider, plain text button
                    // frame with padding and black fill, rounded corners
                    HStack {
                        Button("Superset") {
                            print("superset")
                        }
                        Rectangle()
                            .frame(width: 2, height: 20)
                            .foregroundStyle(.gray)
                        Button("Add") {
                            print("add")
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 35) // Define frame size
                    .background(.black.opacity(0.3))
                    .foregroundStyle(isPicked ? Color("PrimaryColor") : .gray)
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
                        print("NIGGER")
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
                List/*(selection: $selection)*/ {
                    if searchTerm.isEmpty {
                        ForEach(Array(exercisevm.groupedExercises.keys), id: \.self) { key in
                            Section(header: Text(key)) {
                                ForEach(exercisevm.groupedExercises[key]!/*, id: \.id*/) { e in
                                    ExerciseRow(exercise: e, selected: Int.random(in: 0...1) == 0)
                                }
                            }
                        }
                    } else {
                        ForEach(filteredExercises, id: \.id) { e in
                            ExerciseRow(exercise: e, selected: Int.random(in: 0...1) == 0)
                        }
                    }
                }
                .task {
                    print("hi")
                    await exercisevm.fetchExercises()
                } // Exercise List
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .frame(width: 350, height: 570) // Adjusted size to fit content
            .shadow(radius: 10)
            .animation(.easeInOut(duration: 0.5), value: isPresented)
            .background(Color("SecondaryBg"))
            .clipShape(.rect(cornerRadius: 10))
        }
    }
}

struct ExerciseRow: View {
    @State var exercise: ExerciseInfo
    var selected: Bool = false

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://i.ytimg.com/vi/ukQrg5d6Z20/maxresdefault.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 50, maxHeight: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(exercise.muscleGroups.joined(separator: ", "))
                    .foregroundStyle(.secondaryLabel)
            }
            Spacer()
            if selected {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color("PrimaryColor"))
            }
        }
//        .background(selected ? Color("PrimaryColor").opacity(0.3) : Color.clear)
        .listRowBackground(selected ? Color("PrimaryColor").opacity(0.3) : Color.clear)
        .listRowSpacing(16)
    }

}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        ExerciseSearch()
    }
}
