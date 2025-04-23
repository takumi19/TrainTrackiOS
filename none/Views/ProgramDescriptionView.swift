//
//  EditProgramView.swift
//  none
//
//  Created by Max Vaughan on 20.04.2025.
//
import SwiftUI

struct NavBarView: View {
    @State var title: String = ""
//    @State private var

    var body: some View {
        HStack {
            Button {
                print("back")
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(title)
                .font(.title)
                .foregroundStyle(.primaryLabel)
            Spacer()
        }
        .padding()
        .font(.headline)
        .background(Color.primaryBg.ignoresSafeArea(edges: .top))
        .accentColor(.primaryLabel)
//        .padding()
    }
}

// ---------------------------
struct ProgramDescriptionView: View {
    @Environment(\.dismiss) var dismiss

    @State private var programName: String = ""
    @State private var programDescription: String = ""
    @State private var selectedWeekCount: Int = 1

    var body: some View {
        VStack(spacing: 0) {
            // Main Content
            Form {
                Section(header: Text("Enter the program name").foregroundColor(.white)) {
                    TextField("Program name", text: $programName)
                        .foregroundColor(.white)
                        .listRowBackground(Color.secondaryBg)
                }

                Section(header: Text("Enter program description").foregroundColor(.white)) {
                    TextField("Program description", text: $programDescription)
//                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.white)
                        .listRowBackground(Color.secondaryBg)
                }

                Section(header: Text("Program weeks").foregroundColor(.white)) {
                    Picker("Weeks", selection: $selectedWeekCount) {
                        ForEach(1...12, id: \.self) { week in
                            Text("\(week)").tag(week)
                        }
                    }
                    .pickerStyle(.menu)
                    .listRowBackground(Color.secondaryBg)
                }
            }
            .scrollContentBackground(.hidden)

            Spacer()

            NavigationLink(destination: ProgramWeeksView(program: .init(name: "Jim Wendler's 5/3/1", description: "6 Days a week program with a 3 day microcycle: Chest and Back, Arms and Shoulders, Legs.", weekCount: 3, weeks: initWeeks()))) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .foregroundColor(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
            }
            .padding(.bottom, 8)
//            Button(action: {
//                print("Next tapped")
//            }) {
//                Text("Next")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.green.opacity(0.3))
//                    .foregroundColor(.green)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.horizontal)
//            }
//            .padding(.bottom, 8)
        }
        .background(.primaryBg)
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
        .background(.primaryBg)
        .toolbar(.hidden, for: .tabBar) 
//        .tabBarVisible()  // Optional: Custom modifier to ensure tab bar is shown
    }
}

// ---------------------------


#Preview {
//    EditProgramView()
    //    ProgramDetailsView()
    NavigationStack {
        ForEach(0..<3) { index in
            NavigationLink(destination: ProgramDescriptionView()) {
                Text("Link number \(index)")
            }
        }
    }
//    EditProgramView()
//    NavBarView(title: "Edit Program")
}
