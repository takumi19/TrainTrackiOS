//
//  LogsViewModel.swift
//  none
//
//  Created by Max Vaughan on 17.03.2025.
//

import SwiftUI

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

class HistoryViewModel: ObservableObject {
    @Published private var workouts: [Workout]

    init() {
        self.workouts = []
    }
    init(workouts: [Workout]) {
        self.workouts = workouts
    }

//    init(userId: Int) {
//        await fetchWorkouts()
//    }

//    func fetchWorkouts() async {
//        APIManager.shared.getUserLogs { [self] result in
//            switch result {
//            case .success(let workouts):
//                print("got the workouts")
//                self.workouts = workouts
//                print(self.workouts)
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

    func addWorkout(_ workout: Workout) {
        workouts.append(workout)
        workouts.sort { $0.date > $1.date } // Sort by latest date
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return "\(minutes):\(seconds)"
    }

    func sortedByDate() -> [Workout] {
        return workouts.sorted {
            $0.date < $1.date
        }
    }

    func groupedByMonth() -> [String: [Workout]] {
        var dict = Dictionary<String, [Workout]>()
        var prevMonth: Int? = nil

        for w in workouts {
            let currMonth = w.date.get(.month)

            if prevMonth == nil || currMonth == prevMonth {
                let c = DateComponents(month: currMonth)
                let date = Calendar.current.date(from: c)!.formatted(Date.FormatStyle().month(.wide).year(.defaultDigits))

                if dict[date] == nil {
                    dict[date] = [w]
                } else {
                    dict[date]!.append(w)
                }

                prevMonth = currMonth
            }
        }

        return dict
    }

    func groupedByMonth1() -> [Int: [Workout]] {
        var dict = Dictionary<Int, [Workout]>()
        var prevMonth: Int? = nil

        for w in workouts {
            let currMonth = w.date.get(.month)

            if prevMonth == nil || currMonth == prevMonth {
//                let c = DateComponents(month: currMonth)
//                let date = Calendar.current.date(from: c)!.formatted(Date.FormatStyle().month(.wide).year(.defaultDigits))

                if dict[currMonth] == nil {
                    dict[currMonth] = [w]
                } else {
                    dict[currMonth]!.append(w)
                }

                prevMonth = currMonth
            }
        }

        return dict
    }

    func groupedWorkouts() -> [(month: String, workouts: [Workout])] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy" // e.g., "March, 2025"

        let grouped = Dictionary(grouping: sortedByDate()) { workout in
            dateFormatter.string(from: workout.date)
        }

        return grouped.map { (month: $0.key, workouts: $0.value) }
            .sorted { $0.month > $1.month } // assumes recent months are "greater"
    }
}
