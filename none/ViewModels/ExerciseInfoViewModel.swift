//
//  ExerciseInfoViewModel.swift
//  none
//
//  Created by Max Vaughan on 15.04.2025.
//
import Foundation
import Synchronization

class ExerciseInfoViewModel: ObservableObject {
    @Published var exercises: [ExerciseInfo] = []
    @Published var groupedExercises: [String: [ExerciseInfo]] = [:]

    func fetchExercises() async {
        APIManager.shared.listExercises { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let exercises):
                    self.exercises = exercises
                    self.groupedExercises = self.groupedByLetters()
                    print("WE COOKIN")
                    for e in exercises {
                        print("\(e.id): " + e.name)
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    print("WE COOKED")
                }

            }
        }
    }

    func groupedByLetters() -> [String: [ExerciseInfo]] {
        var res: [String: [ExerciseInfo]] = [:]
        for e in exercises {
            let currChar = e.name.first!.description
            if res[currChar] == nil {
                res[currChar] = [ e ]
            } else {
                res[currChar]!.append(e)
            }
        }
        return res
    }
}
