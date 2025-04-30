//
//  ShareViewModel.swift
//  none
//
//  Created by Max Vaughan on 25.04.2025.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [UserModel] = []

    var sortedUsers: [UserModel] {
        users.sorted { $0.fullName < $1.fullName }
    }

    func fetchUsers() {
        APIManager.shared.getUsers { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users
                    print("Got the users")
                    for user in users {
                        print("\(user.id): " + user.email)
                    }

                case .failure(let error):
                    print("Got the error:", error, terminator: "; ")
                    print(error.localizedDescription)
                }

            }
        }
    }
}
