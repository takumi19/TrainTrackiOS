import SwiftUI

// Dummy model so the preview runs
struct Program: Identifiable {
    let id = UUID()
    var name: String
    var coach: String
    var description: String
    var currentWorkout: CurrentWorkout
}

struct CurrentWorkout: Identifiable {
    let id = UUID()
    var exercises: [(name: String, setNumber: Int, bestSetInfo: String)]
}

struct ProgramCarousel: View {
    let programs: [Program]
    @State private var page = 0

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $page) {
                ForEach(programs.indices, id: \.self) { idx in
                    StartedProgramCard(program: programs[idx])
                        .tag(idx)
                        .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 330)

            HStack(spacing: 8) {
                ForEach(programs.indices, id: \.self) { idx in
                    Circle()
                        .fill(idx == page ? Color("PrimaryColor") : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .animation(.easeInOut, value: page)
    }
}

/* -------------------------------------------------------------------- */
struct StartedProgramCard: View {
    let program: Program

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Header
            HStack(alignment: .top) {
                Image("program_image")
                    .resizable()
                    .frame(width: 65, height: 65)
                VStack(alignment: .leading) {
                    Text(program.name)
                        .font(.headline)
                    Spacer()
                    Text("by: \(program.coach)")
                        .font(.subheadline)
                        .foregroundStyle(.secondaryAccent)
                    Spacer()
                    Text("Week 1 - Day 1")
                        .font(.caption)
                        .foregroundStyle(.secondaryLabel)
                }
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
                        .font(.system(size: 20, weight: .bold))
                        .symbolRenderingMode(.monochrome)
                        .imageScale(.large)
                }
            } // Card Header
            .frame(maxHeight: 70)

            Spacer()

            // GRID
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
                ForEach(program.currentWorkout.exercises.indices, id: \.self) { index in
                    Divider()
                    HStack {
                        Text(program.currentWorkout.exercises[index].name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("\(program.currentWorkout.exercises[index].setNumber)")
                            .frame(maxWidth: 60, alignment: .center)
                        Spacer()
                        Text(program.currentWorkout.exercises[index].bestSetInfo)
                            .frame(maxWidth: 101, alignment: .trailing)
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                }
            }
            // GRID

            Spacer()

            Button {
                print("Add something")
            } label: {
                Text("Continue")
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 24)
            .padding(12)
            .background(.green.opacity(0.3))
            .clipShape(.buttonBorder)
            .foregroundStyle(Color("PrimaryColor"))
            .fontWeight(.semibold)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondaryBg)
        .cornerRadius(16)
        .shadow(radius: 6)
    }
}

struct ProgramsView: View {
    let currWorkout: CurrentWorkout
    let programs: [Program]
    @State var showShareScreen: Bool = false
    @State var shareId: Int = 0
//    @State var deleteId: Int = 0

    init() {
        currWorkout = CurrentWorkout(exercises: [
            ("Bench Press (Barbell)", 3, "100 kg x 1"),
            ("Pull Ups (Bodyweight)", 5, "22"),
            ("Squat Bottom Hold", 1, "50 kg x 30 sec")
        ])
        programs = [
            Program(name: "5/3/1 Strength", coach: "Jim Wendler", description: "Description for 531", currentWorkout: currWorkout),
            Program(name: "GZCLP", coach: "Cody Lefever", description: "Description for GZCLP", currentWorkout: currWorkout),
            Program(name: "PHUL",  coach: "Brandon Campbell", description: "Description for GZCLP", currentWorkout: currWorkout)
        ]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    Text("Continue Program")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWidth(.condensed)
                        .fontWeight(.bold)

                    // NOTE: The padding is set to -16 here and to +16 in the carousel itself, because
                    // if there is no padding on the level of carousel then the program cards stick to each other
                    // However, there also has to be padding for the other views in the page hierarchy
                    ProgramCarousel(programs: self.programs)
                        .padding(.horizontal, -16)

                    Spacer().frame(height: 36)
                    HStack {
                        Text("Program Templates")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                            .fontWidth(.condensed)
                            .fontWeight(.bold)
                        Spacer()
                        // ---
                        NavigationLink(destination: ProgramDescriptionView()) {
                            Image(systemName: "plus")
                                .foregroundStyle(Color("PrimaryColor"))
                                .font(.system(size: 20, weight: .bold))
                                .symbolRenderingMode(.monochrome)
                        }
                        // ---
                    }

                    ForEach(programs) { program in
                        NavigationLink(destination: ProgramDescriptionView()) {
                            ProgramCardView(program: program, showShareScreen: self.$showShareScreen, shareId: $shareId)
                                .padding(.bottom)
                        }
                        .buttonStyle(.plain)
                    }

                } // ScrollView
                .padding(.horizontal)

                if self.showShareScreen {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { self.showShareScreen = false }
                        }
                        .transition(.opacity)
                        .zIndex(1)
                    ShareScreen(isPresented: $showShareScreen, programId: 0)
                        .transition(.popUp)
                        .zIndex(2)
                }
            } // ZStack
            .background(Color.primaryBg)
            .navigationTitle(Text("Programs"))
            .animation(.spring(response: 0.2, dampingFraction: 0.8),
                       value: showShareScreen)
        }
    }
}

struct ProgramCardView: View {
    @State var program: Program
    @Binding var showShareScreen: Bool
    @Binding var shareId: Int

    var body: some View {
        HStack {
            Image(systemName: "dumbbell")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 32, maxHeight: 32)
            VStack(alignment: .leading, spacing: 12) {
                Text(program.name)
                    .font(.headline)
                Text(program.coach)
                    .font(.subheadline)
                    .foregroundStyle(.secondaryAccent)
                Text("\(Int.random(in: 1...5)) Weeks")
                    .font(.caption)
                    .foregroundStyle(.secondaryLabel)

            }
            Spacer()
            Menu {
                Button {
                } label: {
                    Label("Start Program", systemImage: "rectangle.stack.badge.plus")
                }
                Button {
                } label: {
                    Label("Edit", systemImage: "folder.badge.plus")
                }
                Button {
                    // Trigger ShareScreen to appear
                    share()
                } label: {
                    Label("Manage Access", systemImage: "rectangle.stack.badge.person.crop")
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
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondaryBg)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    func share() {
        self.showShareScreen.toggle()
        self.shareId = 1
    }
}

/* -------------------------------------------------------------------- */

#Preview {
    //    let currWorkout = CurrentWorkout(exercises: [
    //        ("Bench Press (Barbell)", 3, "100 kg x 1"),
    //        ("Pull Ups (Bodyweight)", 5, "22"),
    //        ("Squat Bottom Hold", 1, "50 kg x 30 sec")
    //    ])
    //    ProgramCarousel(programs: [
    //        Program(name: "5/3/1 Strength", coach: "Jim Wendler", currentWorkout: currWorkout),
    //        Program(name: "GZCLP", coach: "Cody Lefever", currentWorkout: currWorkout),
    //        Program(name: "PHUL",  coach: "Brandon Campbell", currentWorkout: currWorkout)
    //    ])
    ProgramsView()
}
