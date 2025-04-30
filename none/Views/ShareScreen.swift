//
//  ShareWorkout.swift
//  none
//
//  Created by Max Vaughan on 25.04.2025.
//

import SwiftUI

struct ShareScreen: View {
    @Binding var isPresented: Bool
    @State var programId: Int
    @State var isPicked: Bool = false
    @State private var searchTerm: String = ""
    @State private var selection = Set<Int64>()
    @StateObject var uservm: UsersViewModel = UsersViewModel()

    var filteredUsers: [UserModel] {
        guard !searchTerm.isEmpty else { return uservm.sortedUsers }
        return uservm.sortedUsers.filter {
            $0.fullName.localizedCaseInsensitiveContains(searchTerm) ||
            $0.login.localizedCaseInsensitiveContains(searchTerm)
        }
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
                    .frame(width: 32, height: 32) // Define frame size

                    Spacer()

                    Button("Share") {
                        isPresented = false
                        print("Share")
                    }
                    .foregroundStyle(selection.isEmpty ? .gray : Color("PrimaryColor"))
                    .padding(.horizontal)
                    .frame(height: 32)
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
                        print(".........")
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
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
//                    if searchTerm.isEmpty {
//                        ForEach(Array(uservm.groupedExercises.keys), id: \.self) { key in
//                            Section(header: Text(key)) {
//                                ForEach(uservm.groupedExercises[key]!/*, id: \.id*/) { e in
//                                    UserRow(exercise: e, selected: selection.contains(e.id))
//                                        .onTapGesture {
//                                            toggleSelection(e.id)
//                                        }
//                                }
//                            }
//                        }
//                    } else {
                    ForEach(filteredUsers, id: \.id) { user in
                        UserRow(user: user, selected: selection.contains(user.id))
                            .onTapGesture {
                                toggleSelection(user.id)
                            }
                    }
//                    }
                }
                .task {
                    uservm.fetchUsers()
//                    exercisevm.fetchExercises()
                } // Exercise List
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity)

                Spacer()
            }
            .frame(width: 350, height: 600)
            .shadow(radius: 10)
            .animation(.easeInOut(duration: 0.5), value: isPresented)
            .background(Color("SecondaryBg"))
            .clipShape(.rect(cornerRadius: 10))
        }
    }

    private func toggleSelection(_ id: Int64) {
        if selection.contains(id) {
            selection.remove(id)
        } else {
            selection.insert(id)
        }
    }
}

struct UserRow: View {
    @State var user: UserModel
    var selected: Bool

    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
//                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 40, maxHeight: 40)
                .clipShape(Circle())
//                .foregroundColor(.white)
            VStack(alignment: .leading) {
                Text(user.fullName)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(user.login)
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
    struct PreviewWrapper: View {
        @State var isPresented: Bool = true
        @State var workout = testingWorkout

        var body: some View {
            ShareScreen(isPresented: $isPresented, programId: 0)
        }
    }

    return PreviewWrapper()
}
